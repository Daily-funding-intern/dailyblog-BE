import boto3
import re
from django.conf import settings
import uuid,os

def get_s3_client():
    return boto3.client(
        's3',
        aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
        aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
        region_name=settings.AWS_S3_REGION_NAME,
    )

def upload_file_to_s3_tmp(file):
    s3 = get_s3_client()
    _, ext = os.path.splitext(file.name) #파일명 + 확장자 저장
    safe_name = f"{uuid.uuid4().hex}{ext.lower()}"
    temp_key = f"tmp/uploads/{safe_name}"
    s3.upload_fileobj(
        file,
        settings.AWS_STORAGE_BUCKET_NAME,
        temp_key,
        ExtraArgs={'ContentType': file.content_type}
    )
    return (
        f"https://{settings.AWS_STORAGE_BUCKET_NAME}.s3."
        f"{settings.AWS_S3_REGION_NAME}.amazonaws.com/{temp_key}"
    )

def finalize_uploaded_images(html_content):
    s3 = get_s3_client()
    bucket = settings.AWS_STORAGE_BUCKET_NAME

    tmp_urls = re.findall(
        r'https://[^"]+/tmp/uploads/[^"]+',
        html_content
    )

    for tmp_url in tmp_urls:
        tmp_key = tmp_url.split('.amazonaws.com/')[-1]
        filename = tmp_key.split('_', 1)[-1]
        final_key = f"posts/{uuid.uuid4().hex}_{filename}"
        s3.copy_object(
            Bucket=bucket,
            CopySource={
                'Bucket': bucket,
                'Key': tmp_key
            },
            Key=final_key
        )
        s3.delete_object(
            Bucket=bucket,
            Key=tmp_key
        )
        final_url = (
            f"https://{bucket}.s3."
            f"{settings.AWS_S3_REGION_NAME}.amazonaws.com/{final_key}"
        )
        html_content = html_content.replace(tmp_url, final_url)

    return html_content
        