# DAWI

**DAWI** (Arabic/Darija for "remedy" or "cure") is an AI-powered health assistant that helps patients scan, understand and track their medical prescriptions and records.

Prescriptions in Morocco are often written in French and dense medical terminology. DAWI scans the document, extracts the text with OCR, and uses AI to turn it into a clear summary, a medication list, reminders and a care history.

> All extracted data comes from documents the patient uploads or scans. DAWI does not invent medical information.

## Features

- **Scan and extract**: photograph or upload a prescription; OCR (French + English) reads the text.
- **Understand**: AI structures the document (medications, doctor, dates) and explains it in plain language.
- **Medications and appointments**: track active treatments and upcoming visits, with a calendar view.
- **Document vault**: keep all records in one place.
- **AI assistant**: ask questions about your medications and prepare for doctor visits.
- **Profile and preferences**: account, preferred language, privacy settings.

## Tech stack

| Part | Technology |
|---|---|
| Frontend | Flutter (web + mobile), Provider |
| Backend | Python, FastAPI, SQLAlchemy, SQLite |
| OCR | Tesseract (via pytesseract) |
| AI | Claude (Anthropic API) |
| Packaging | Docker, docker compose, nginx |

---

# Setup guide

Choose **one** way to run the project. Option A (Docker) is the easiest and is what we recommend.

## What you need

| Tool | Needed for | Check with |
|---|---|---|
| [Git](https://git-scm.com/downloads) | downloading the project | `git --version` |
| [Flutter SDK](https://docs.flutter.dev/get-started/install) | building the app | `flutter --version` |
| [Docker](https://docs.docker.com/get-docker/) with Compose | Option A | `docker compose version` |
| Python 3.12+ and Tesseract | Option B only | `python3 --version`, `tesseract --version` |
| An AI API key (Anthropic) | AI features | see Step 2 |

## Step 1: Get the code

```bash
git clone https://github.com/salmao555/DAWI-APPLICATION.git
cd DAWI-APPLICATION
flutter pub get
```

## Step 2: Add your API key

The backend reads its secrets from `backend/.env`. This file is never committed to Git.

Create `backend/.env` with:

```env
ANTHROPIC_API_KEY=your_key_here
ANTHROPIC_MODEL=your_model_name_here
JWT_SECRET=any-long-random-string
```

- `ANTHROPIC_API_KEY`: your key from the Anthropic console.
- `ANTHROPIC_MODEL`: the model name you want to use (see the Anthropic docs for current names).
- `JWT_SECRET`: any long random text. Change it from the default.

Without a valid key the app still runs, registration and login work, and OCR extracts text, but the AI analysis and the assistant show an error.

## Option A: Run with Docker (recommended)

**1. Build the web app** (nginx serves this build):

```bash
flutter build web --release
```

**2. Start everything:**

```bash
docker compose up -d --build
```

The first start is slow because Docker downloads Python and Tesseract with its French and Arabic language packs.

**3. Open it:**

| What | Address |
|---|---|
| App | http://localhost:8080 |
| API | http://localhost:8000 |
| API docs | http://localhost:8000/docs |

Create an account in the app and log in.

**Useful commands:**

```bash
docker compose ps                 # are both services Up?
docker compose logs -f backend    # watch backend logs
docker compose down               # stop everything
```

Your database is stored in `./data` and uploaded files in `./uploads`, so they survive restarts.

**After you change Flutter code,** run `flutter build web --release` again and hard refresh the page (`Ctrl+Shift+R`). After changing backend code, run `docker compose up -d --build`.

## Option B: Run without Docker (for development)

Use two terminals.

**Terminal 1: backend**

```bash
cd backend
python3 -m venv venv
source venv/bin/activate          # Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

Install Tesseract with French and English data:
- Ubuntu/Debian: `sudo apt install tesseract-ocr tesseract-ocr-fra tesseract-ocr-eng`
- macOS: `brew install tesseract tesseract-lang`
- Windows: install from the [Tesseract installer](https://github.com/UB-Mannheim/tesseract/wiki) and set `TESSERACT_CMD` in `backend/.env` to the path of `tesseract.exe`.

**Terminal 2: frontend**

```bash
flutter run -d chrome
# or, to open in any browser on a fixed port:
flutter run -d web-server --web-port 3000
```

While it runs, press `r` for hot reload and `R` for a full restart.

> Do not run Option A and Option B at the same time. Both use port 8000.

## Try it on a phone (same Wi-Fi)

1. Start the app with Option A.
2. Find your computer's IP address (for example `192.168.1.23`): `ip -4 addr` (Linux), `ipconfig getifaddr en0` (macOS), `ipconfig` (Windows).
3. Allow the ports through your firewall (Linux with firewalld: `sudo firewall-cmd --add-port=8080/tcp --add-port=8000/tcp`).
4. On the phone, open `http://<your-ip>:8080`.

Browsers only allow secure storage and the camera on `https://` or `localhost`. On a plain `http://` address, login can fail. On Android Chrome, open `chrome://flags`, enable **Insecure origins treated as secure**, add `http://<your-ip>:8080`, and relaunch Chrome. Uploading from the gallery works without this.

## Test the scanner

Scan or upload a clear, well-lit photo of a French prescription. Check that the drug names and doses appear in the extracted text, then save the document. The medications then show up on the Home screen.

## Troubleshooting

| Problem | Cause and fix |
|---|---|
| `port is already allocated` or `address already in use` on 8000 | Another backend is running. Stop it (`Ctrl+C`) or run `docker compose down`, then start again. |
| Register or login spinner never ends | The backend is not running. Check `docker compose ps` and `docker compose logs backend`. |
| Scan shows "NetworkError" | Look at `docker compose logs --tail=40 backend`. `invalid x-api-key` means the key in `backend/.env` is missing or wrong. Fix it, then run `docker compose down && docker compose up -d`. |
| Page still shows the old design | Run `flutter build web --release`, then hard refresh with `Ctrl+Shift+R`. If it persists: browser DevTools, Application, Service Workers, Unregister. |
| `FlutterSecureStorageWeb only works in secure contexts` | You opened the app on an `http://` address that is not `localhost`. Use `localhost`, HTTPS, or the Chrome flag above. |
| OCR output is garbled | Use a sharper, straighter photo. Make sure the French language pack is installed (`tesseract --list-langs` should show `fra`). |
| Changes to `.env` have no effect | Restart the backend: `docker compose down && docker compose up -d`. |

## Project structure

```
DAWI-APPLICATION/
├── lib/                  # Flutter app (screens, widgets, theme, services)
├── web/                  # Web entry point and manifest
├── backend/              # FastAPI backend
│   ├── app/              # routers, models, OCR and AI services
│   ├── Dockerfile
│   └── .env              # your secrets (not in Git)
├── docker-compose.yml    # backend + nginx frontend
├── nginx.conf            # serves the Flutter web build
├── data/                 # SQLite database (created at runtime)
└── uploads/              # uploaded documents (created at runtime)
```

## Security notes

- Never commit `backend/.env` or API keys.
- Change `JWT_SECRET` from the default before sharing the app.
- DAWI is a study and tracking aid. It does not replace a doctor's advice.
