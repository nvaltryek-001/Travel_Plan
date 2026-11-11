# ✈️ Travel Plan — AI-Powered Road Trip Planner

A cross-platform **Flutter** app that plans complete road trips with **Google Gemini AI**, checks live **weather**, tracks **trip expenses**, and saves every plan per user in **Firebase**.

![Flutter](https://img.shields.io/badge/Flutter-3.35+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9+-0175C2?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase)
![Gemini](https://img.shields.io/badge/AI-Gemini%202.5%20Flash-8E75B2)

---

## 📸 Screenshots

| Login | Trip Planner | AI Plan |
|:---:|:---:|:---:|
| ![Login](screenshots/login.png) | ![Home](screenshots/home.png) | ![Plan](screenshots/plan.png) |

| Weather | Expenses | Suggestions |
|:---:|:---:|:---:|
| ![Weather](screenshots/weather.png) | ![Expenses](screenshots/expenses.png) | ![Suggestions](screenshots/suggestions.png) |

> Capture instructions are in [`screenshots/README.md`](screenshots/README.md).

---

## ✨ Features

| Module | What it does |
|---|---|
| 🔐 **Authentication** | Email/password sign-up & login with Firebase Auth, email verification, OTP-based password reset |
| 🧠 **AI Trip Planner** | Gemini generates a day-by-day route plan from start/end city, days, members, budget, interests and vehicle (Bike / Car / EV) |
| 💰 **Budget Estimation** | AI estimates fuel/charging, food, stay and activity costs for the selected budget level |
| 🛣️ **Smart Advisor** | Rain-safety routes, traffic timing tips, fuel/EV-charging stops and accommodation suggestions |
| 📍 **Location** | Auto-detects current city via GPS (Geolocator + Geocoding) |
| ☁️ **Weather** | Live weather for every stop on the route (OpenWeatherMap) |
| 📊 **Expense Tracker** | Add expenses by category and view charts (fl_chart) |
| 🗺️ **Trip Suggestions** | AI-curated destination ideas based on your interests |
| 🕘 **History** | Saved plans and expenses stored per user in Cloud Firestore |
| 🗺️ **Navigation** | Opens the route directly in Google Maps |

## 🚀 What's new in v2.0

- **New look:** Material 3 theme with Poppins font, rounded inputs, floating snackbars, smooth page transitions
- **Dark mode:** follows the system light/dark setting automatically
- **Security:** all API keys removed from source code; injected at build time with `--dart-define`
- **Clear errors:** friendly message when the Gemini key is missing instead of a crash
- **Rebranded:** app name *Travel Plan* across Android, iOS and Web
- **Tests:** replaced the broken default counter test with config tests

---

## 🏗️ Tech Stack

- **Frontend:** Flutter (Material 3), Google Fonts
- **AI:** `google_generative_ai` (Gemini 2.5 Flash)
- **Backend:** Firebase Authentication, Cloud Firestore
- **APIs:** OpenWeatherMap, Geolocator, Geocoding, url_launcher
- **Charts:** fl_chart

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry, theme, home tabs, AI trip planner
├── config.dart                   # App constants + API keys (from --dart-define)
├── auth_service.dart             # Firebase auth helpers
├── login_screen.dart             # Login / sign-up / reset password UI
├── weather_screen.dart           # Live weather for route stops
├── expense_tab.dart              # Expense tracker with charts
├── expenses_history_screen.dart  # Past expenses
├── plans_history_screen.dart     # Saved trip plans
└── trip_suggestions_screen.dart  # AI destination suggestions
```

---

## ⚙️ Setup

### 1. Prerequisites
- Flutter SDK 3.35+ (`flutter doctor`)
- A Firebase project — enable **Email/Password** sign-in and **Cloud Firestore**
- [Gemini API key](https://aistudio.google.com/app/apikey) and [OpenWeatherMap API key](https://openweathermap.org/api)

### 2. Clone & install
```bash
git clone https://github.com/nvaltryek-001/Travel_Plan.git
cd Travel_Plan
flutter pub get
```

### 3. Connect Firebase
```bash
dart pub global activate flutterfire_cli
flutterfire configure      # creates lib/firebase_options.dart + google-services.json
```

### 4. Add API keys
```bash
cp env.example.json env.json   # then put your real keys in env.json (git-ignored)
```

### 5. Run
```bash
flutter run --dart-define-from-file=env.json
# build APK
flutter build apk --release --dart-define-from-file=env.json
```

---

## 🔑 Demo Login

The app uses **your own Firebase project**, so create the demo account once:

1. Run the app → tap **Sign Up**
2. Register with:

| Field | Value |
|---|---|
| **Email** | `demo.travelplan@gmail.com` |
| **Password** | `Travel@123` |

3. Verify the email (or disable email verification in Firebase for demos), then log in.

> Tip: you can also add this user directly in **Firebase Console → Authentication → Add user**.

---

## 🧪 Tests
```bash
flutter test
```

## 🙏 Credits
Based on [smart_travel_app](https://github.com/itsvishwasj/smart_travel_app) by **itsvishwasj**, extended with a redesigned UI, dark mode, secure key handling and documentation.

## 📄 License
For educational use.
