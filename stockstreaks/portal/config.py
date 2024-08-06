import base64
import os
import secrets

from kinde_sdk.kinde_api_client import GrantType
from dotenv import load_dotenv


load_dotenv()

def generate_code_verifier(length=46):
    token = secrets.token_bytes(length)
    return base64.urlsafe_b64encode(token).decode('utf-8').rstrip('=')
# Load environment variables from .env file

SITE_HOST = os.getenv('SITE_HOST')
SITE_PORT = os.getenv('SITE_PORT')
SITE_URL =  os.getenv('SITE_URL')
LOGOUT_REDIRECT_URL =  os.getenv('LOGOUT_REDIRECT_URL')
KINDE_CALLBACK_URL =  os.getenv('KINDE_CALLBACK_URL')
CLIENT_ID =  os.getenv('CLIENT_ID')
CLIENT_SECRET =  os.getenv('CLIENT_SECRET')
KINDE_ISSUER_URL =  os.getenv('KINDE_ISSUER_URL')
GRANT_TYPE =  os.getenv('GRANT_TYPE')
CODE_VERIFIER = generate_code_verifier()
TEMPLATES_AUTO_RELOAD = os.getenv('TEMPLATES_AUTO_RELOAD')
SESSION_TYPE = os.getenv('SESSION_TYPE')
SESSION_PERMANENT = os.getenv('SESSION_PERMANENT')
SECRET_KEY = os.getenv('SECRET_KEY')
MGMT_API_CLIENT_ID = os.getenv('MGMT_API_CLIENT_ID')
MGMT_API_CLIENT_SECRET = os.getenv('MGMT_API_CLIENT_SECRET')