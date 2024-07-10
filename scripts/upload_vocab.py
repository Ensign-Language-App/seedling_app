import firebase_admin
from firebase_admin import credentials, firestore
import json

# Path to your service account key file
service_account_key_path = '/Users/Justin/Projects/Ensign/CS480/Ensign_Language_App/seedling_app/scripts/firebase-adminsdk.json'

# Initialize the Firebase Admin SDK
cred = credentials.Certificate(service_account_key_path)
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()

# Load the vocabulary JSON data
vocab_json_path = '/Users/Justin/Projects/Ensign/CS480/Ensign_Language_App/seedling_app/scripts/vocab.json'
with open(vocab_json_path, 'r', encoding='utf-8') as f:
    vocab_data = json.load(f)

# Function to upload vocabulary data to Firestore
def upload_vocab_to_firestore(data, collection_name='Vocabulary'):
    for vocabulary, vocab_data in data.items():
        for subject, subject_data in vocab_data.items():
            for topic, topic_data in subject_data.items():
                for word, translations in topic_data.items():
                    doc_ref = db.collection(collection_name).document(subject).collection(topic).document(word)
                    doc_ref.set(translations)
                    print(f'Uploaded {word} in {subject}/{topic}')

# Upload the vocabulary data
upload_vocab_to_firestore(vocab_data)

print('Vocabulary data uploaded successfully.')
