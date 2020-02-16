import os
import json
import boto3
from botocore.client import Config
from botocore.exceptions import ClientError
from flask import Flask, request

app = Flask(__name__)


S3CONF = boto3.resource(
    "s3",
    endpoint_url=os.environ["S3_URL"],
    aws_access_key_id=os.environ["S3_ACCESS_KEY"],
    aws_secret_access_key=os.environ["S3_SECRET_KEY"],
    verify=False
)

@app.route('/')
def error():
    return "Please, send a post request with file."

@app.route("/minio-upload/<bucket>/<filename>", methods=["POST"])
def index(bucket, filename):
    if "file" not in request.files:
        return "Please send a file"

    file = request.files["file"]
    file.filename = filename
    try:
        S3CONF.Bucket(bucket).upload_fileobj(
            file, filename, ExtraArgs={"ContentType": file.content_type}
        )
        return {"status": "ok"}
    except ClientError as e:
        return ({"error": str(e)}, 422)
