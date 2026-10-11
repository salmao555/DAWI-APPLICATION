# Dawi

Dawi (Arabic/Darija for "remedy" or "cure") is an AI-powered mobile health assistant that helps patients scan, understand, and track their medical prescriptions and records — in their own language.

## The problem

Medical prescriptions and records in Morocco are often written in French or in dense medical terminology, while many patients speak Darija or Tamazight day to day. This language and terminology gap can lead to misunderstood treatments, medication errors, and disengagement from care.

## What Dawi does

- **Scan & extract** — Patients upload or scan certified medical documents (prescriptions, medical records); OCR extracts the text automatically.
- **Understand, in your language** — AI reformulates and explains the medical content in Darija or Tamazight, generating a plain-language summary of the patient's situation.
- **Medication alerts** — Flags and reminds patients about the medications they're taking.
- **Care history tracking** — Patients can see which doctor prescribed what, and the date of their last appointment.
- **AI health companion** — A conversational AI agent (powered by Gemini) analyzes the patient's data to give personalized advice and daily reminders for habits that support their overall health.

All extracted data comes exclusively from certified medical documents the patient has uploaded or scanned — Dawi does not fabricate medical information. In short, Dawi turns scattered medical paperwork into an ongoing, understandable health tracker.

## Tech stack

- **Frontend:** Flutter
- **Backend:** Python — FastAPI / Django
- **Conversational AI:** Google Gemini
- **Document processing:** OCR for scanned/photographed medical documents
- **Deployment:** Docker

## Project structure

```
Dawi-application/
├── lib/       # Flutter (Dart) mobile application source
└── backend/   # FastAPI / Django backend, OCR pipeline, Gemini integration
```

## 📱 App Screenshots & Overview

## 📱 App Screenshots & Overview

| Screenshot | Feature Name | Description |
| :---: | :--- | :--- |
| <img src="https://github.com/user-attachments/assets/75f7154a-487c-4ec6-a1d2-70e08ed6b8ea" width="180" alt="Home Dashboard" /> | **Home Dashboard** | Main landing screen displaying quick status cards, metric counts for treatments/documents, quick action buttons, and active medication reminders. |
| <img src="https://github.com/user-attachments/assets/8c82e6ee-2174-4ec5-8205-904c2a3d6aae" width="180" alt="Document Vault" /> | **Document Vault** | Centralized storage tab with category filters (Prescription, Lab Report, Medical) to organize and upload all patient medical records. |
| <img src="https://github.com/user-attachments/assets/bd75e43e-7127-467f-9704-4ae7d9b2b903" width="180" alt="My Health" /> | **My Health** | Holistic overview of the patient profile, tracking active treatments, registered physicians, and recent documents with AI-generated previews. |
| <img src="https://github.com/user-attachments/assets/3578ab07-0eb5-4c9e-82c0-dc9b4bd1f974" width="180" alt="Health Assistant" /> | **AI Health Assistant** | Multilingual conversational chat interface supporting Darija, Arabic, and English to answer dosage queries and help prepare for doctor visits. |
| <img src="https://github.com/user-attachments/assets/a3e58309-9282-4810-8faf-4de595933739" width="180" alt="Profile" /> | **User Profile** | Account management screen displaying user details, preferred language settings, privacy options, and app security settings. |
| <img src="https://github.com/user-attachments/assets/003e3a30-dcb3-40fd-8ac4-17d67b8c3aa8" width="180" alt="Scan Modal" /> | **Document Upload** | Action sheet modal giving users the option to instantly scan a document via camera or upload an existing file from their gallery. |
| <img src="https://github.com/user-attachments/assets/1dda11b5-8438-4491-9d75-f8f60011d3e7" width="180" alt="AI Health Summary" /> | **AI Health Summary** | Structured analytical report synthesized from lab results and prescriptions, offering clear breakdowns and general wellness recommendations. |
| <img src="https://github.com/user-attachments/assets/d9016bdc-c286-4bcf-93e9-65c4f7b13b05" width="180" alt="Multilingual Support" /> | **Multilingual AI** | Demonstrates the conversational capability and assistant versatility across regional languages like Moroccan Darija. |


## Getting started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Python 3.x
- Docker (for backend deployment)
- A Gemini API key

### Running the app
```bash
cd lib
flutter pub get
flutter run
```

### Running the backend
See the `backend/` directory for FastAPI/Django-specific setup instructions.

## Status

Actively developed as part of an ongoing personal healthtech project.

## Author

**Rim Kaanane** — [GitHub](https://github.com/rimereld) · [LinkedIn](https://www.linkedin.com/in/kaananerim)
