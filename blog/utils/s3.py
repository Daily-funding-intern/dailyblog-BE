import boto3
from django.conf import settings

def get_s3_client():
    return boto3.client(
        's3',
        aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
        aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
        region_name=settings.AWS_S3_REGION_NAME,
    )

def upload_file_to_s3(file, key):
    s3 = get_s3_client()
    s3.upload_fileobj(
        file,
        settings.AWS_STORAGE_BUCKET_NAME,
        key,
        ExtraArgs={
            'ContentType': file.content_type,
        }
    )
    return f"https://{settings.AWS_STORAGE_BUCKET_NAME}.s3.{settings.AWS_S3_REGION_NAME}.amazonaws.com/{key}"
