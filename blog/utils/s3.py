import boto3
import os
import re
import uuid
from django.conf import settings

def get_s3_client():
    return boto3.client(
        "s3",
        aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
        aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
        region_name=settings.AWS_S3_REGION_NAME,
    )
    
def get_bucket():
    return settings.AWS_STORAGE_BUCKET_NAME

def build_s3_url(key):
    return (
        f"https://{get_bucket()}.s3."
        f"{settings.AWS_S3_REGION_NAME}.amazonaws.com/{key}"
    )

def extract_s3_key(url):
    return url.split(".amazonaws.com/")[-1]

def upload_file_to_s3_tmp(file):
    s3 = get_s3_client()
    _, ext = os.path.splitext(file.name)
    safe_name = f"{uuid.uuid4().hex}{ext.lower()}"
    key = f"tmp/uploads/{safe_name}"
    s3.upload_fileobj(
        file,
        get_bucket(),
        key,
        ExtraArgs={"ContentType": file.content_type},
    )
    return build_s3_url(key)

TMP_IMAGE_PATTERN = re.compile(
    r'https://[^"]+/tmp/uploads/[^"]+'
)

POST_IMAGE_PATTERN = re.compile(
    r'https://[^"]+\.amazonaws\.com/posts/[^"]+'
)

def move_s3_object(src_key, dest_key):
    s3 = get_s3_client()
    bucket = get_bucket()

    s3.copy_object(
        Bucket=bucket,
        CopySource={"Bucket": bucket, "Key": src_key},
        Key=dest_key,
    )
    s3.delete_object(Bucket=bucket, Key=src_key)


def finalize_uploaded_images(html_content):
    tmp_urls = TMP_IMAGE_PATTERN.findall(html_content)

    for tmp_url in tmp_urls:
        src_key = extract_s3_key(tmp_url)
        _, ext = os.path.splitext(src_key)

        dest_key = f"posts/{uuid.uuid4().hex}{ext.lower()}"
        move_s3_object(src_key, dest_key)

        html_content = html_content.replace(
            tmp_url, build_s3_url(dest_key)
        )

    return html_content


def finalize_uploaded_thumbnail(thumbnail_url):
    src_key = extract_s3_key(thumbnail_url)
    _, ext = os.path.splitext(src_key)

    dest_key = f"thumbnails/{uuid.uuid4().hex}{ext.lower()}"
    move_s3_object(src_key, dest_key)

    return build_s3_url(dest_key)

def extract_post_image_urls(html_content):
    return POST_IMAGE_PATTERN.findall(html_content)


def delete_s3_keys(keys):
    if not keys:
        return
    s3 = get_s3_client()
    bucket = get_bucket()
    for key in keys:
        s3.delete_object(Bucket=bucket, Key=key)

def delete_images_from_s3(html_content):
    urls = extract_post_image_urls(html_content)
    keys = [extract_s3_key(url) for url in urls]
    delete_s3_keys(keys)

def delete_thumbnail_from_s3(thumbnail_url):
    if not thumbnail_url:
        return
    delete_s3_keys([extract_s3_key(thumbnail_url)])
