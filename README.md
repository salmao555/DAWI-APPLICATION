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


