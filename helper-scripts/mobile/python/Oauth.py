from google.oauth2 import service_account
from googleapiclient.discovery import build

SCOPES = ['https://www.googleapis.com/auth/cloud-platform']
SERVICE_ACCOUNT_FILE = '../helper-scripts/mobile/python/glorifi-f9440-a17c0b5fcce9.json'

credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE, scopes=SCOPES)
discoveryUrl="https://firebaseappdistribution.googleapis.com/$discovery/rest?version=v1"
fbdist = build('firebaseappdistribution', 'v1', discoveryServiceUrl=discoveryUrl,credentials=credentials)




