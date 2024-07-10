import firebase_admin
from firebase_admin import credentials, firestore
import json

# Path to your service account key file
service_account_key_path = 'path/to/your/serviceAccountKey.json'

# Initialize the Firebase Admin SDK
cred = credentials.Certificate(service_account_key_path)
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()

# Load the vocabulary JSON data
with open('path/to/your/vocab.json', 'r', encoding='utf-8') as f:
    vocab_data = json.load(f)

# Function to upload vocabulary data to Firestore
def upload_vocab_to_firestore(data, collection_name='vocabulary'):
    for subject, subject_data in data['Subjects'].items():
        for topic, topic_data in subject_data.items():
            for word, translations in topic_data.items():
                doc_ref = db.collection(collection_name).document(subject).collection(topic).document(word)
                doc_ref.set(translations)
                print(f'Uploaded {word} in {subject}/{topic}')

# Upload the vocabulary data
upload_vocab_to_firestore(vocab_data)

print('Vocabulary data uploaded successfully.')