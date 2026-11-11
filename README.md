<p align="center">
  <img src="screenshots/banner.svg" alt="Travel Plan banner" width="100%"/>
</p>

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Poppins&weight=600&size=22&duration=2800&pause=800&color=4C6FFF&center=true&vCenter=true&width=620&lines=AI-powered+road+trip+planner+%F0%9F%9A%97;Live+weather+for+every+stop+%E2%9B%85;Track+%26+split+trip+expenses+%F0%9F%92%B0;Never+forget+to+pack+again+%E2%9C%85" alt="Typing animation"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.35+-02569B?logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-3.9+-0175C2?logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase&logoColor=black"/>
  <img src="https://img.shields.io/badge/AI-Gemini%202.5%20Flash-8E75B2?logo=googlegemini&logoColor=white"/>
  <img src="https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web-4C6FFF"/>
  <img src="https://img.shields.io/badge/version-2.0.0-success"/>
</p>

---

## 📖 About

**Travel Plan** is a cross-platform Flutter app that turns a few inputs (where from, where to, how many days, budget, vehicle and interests) into a **complete AI-generated road trip**: route stops, tourist spots, hotels, fuel/EV-charging stops, a cost estimate and safety tips. It also gives live weather along the route, an expense tracker with charts, a packing checklist and a budget splitter for group trips. Each user's plans and expenses are saved to Firebase.

---

## 🎬 App Demo

<p align="center">
  <img src="screenshots/demo.gif" alt="App demo animation" width="300"/>
</p>

> 📌 **About the images:** the screenshots and the demo GIF are **UI previews** that recreate the app's screens (same layout, fields, labels and colours as the Flutter code). To use real device screenshots, run the app and replace the files in [`screenshots/`](screenshots/) using the same file names. The README updates automatically.

---

## 📸 Screenshots

### 1️⃣ Splash & Login
| Splash Screen *(new, animated)* | Login / Sign-up |
|:---:|:---:|
| <img src="screenshots/splash.png" width="260"/> | <img src="screenshots/login.png" width="260"/> |
| Logo scales in with an elastic bounce, then title and tagline slide up and fade in before the app opens. | Email/password login with Firebase. Includes sign-up, email verification and OTP password reset. |

### 2️⃣ AI Trip Planner
| Plan Form | AI-Generated Plan |
|:---:|:---:|
| <img src="screenshots/plan_form.png" width="260"/> | <img src="screenshots/ai_plan.png" width="260"/> |
| Enter From (auto-detected by GPS), To, days, travellers, budget, vehicle, interests and start date. | Gemini returns the cost estimate, route, tourist stops, hotels, fuel/EV stops and Smart Advisor tips. Every place opens in Google Maps. |

### 3️⃣ Weather & Expenses
| Route Weather | Expense Tracker |
|:---:|:---:|
| <img src="screenshots/weather.png" width="260"/> | <img src="screenshots/expenses.png" width="260"/> |
| Live temperature, conditions and humidity for every city on the route, plus manual city search. | Add expenses, split them between travellers, and see the spending breakdown in a chart. |

### 4️⃣ Suggestions & Travel Tools
| Trip Suggestions | Packing Checklist *(new)* | Budget Splitter *(new)* |
|:---:|:---:|:---:|
| <img src="screenshots/suggestions.png" width="230"/> | <img src="screenshots/packing.png" width="230"/> | <img src="screenshots/budget.png" width="230"/> |
| AI-curated destination ideas that match your interests. | Category-wise checklist with an animated progress bar, swipe-to-delete, and saving on the device. | Split the total trip cost; sliders give each person a bigger or smaller share. |

---

## ⚙️ How the App Works

### 🔄 User flow

```mermaid
flowchart TD
    A([🚀 App Launch]) --> B[✨ Animated Splash Screen]
    B --> C{Logged in?}
    C -- No --> D[🔐 Login / Sign Up]
    D --> E[📧 Email Verification]
    E --> F
    C -- Yes --> F[🏠 Home: Plan · Weather · Expenses tabs]
    F --> G[📝 Fill trip form]
    G --> H[🤖 Gemini AI generates plan]
    H --> I[🗺️ Route · Stops · Hotels · Cost · Tips]
    I --> J[💾 Plan saved to Firestore]
    I --> K[⛅ Weather for each route stop]
    I --> L[📍 Open in Google Maps]
    F --> M[💰 Track expenses]
    F --> N[☰ Drawer]
    N --> O[✅ Packing Checklist]
    N --> P[👥 Budget Splitter]
    N --> Q[💡 Trip Suggestions]
    N --> R[🕘 Past Plans / Expenses]
```

### 🧠 How the AI plan is generated

```mermaid
sequenceDiagram
    participant U as 👤 User
    participant App as 📱 Travel Plan
    participant GPS as 📍 Geolocator
    participant AI as 🤖 Gemini 2.5 Flash
    participant DB as 🔥 Firestore
    participant W as ⛅ OpenWeather

    U->>App: Open Plan tab
    App->>GPS: Get current location
    GPS-->>App: "Bengaluru"
    U->>App: To, days, budget, vehicle, interests
    App->>AI: Structured prompt + JSON schema
    AI-->>App: JSON (cost, routeStops, touristStops, hotels, tips)
    App->>App: Parse & render plan cards
    App->>DB: Save plan under users/{uid}/plans
    App->>W: Fetch weather for routeStops
    W-->>App: Temp, condition, humidity
    App-->>U: Full trip plan + route weather
```

### 🪜 Step by step

1. **Launch:** the animated splash screen plays while Firebase starts up.
2. **Sign in:** `AuthWrapper` listens to `FirebaseAuth.authStateChanges()` and shows Login or Home.
3. **Plan:** the user's location is detected with **Geolocator + Geocoding** and filled into *From*.
4. **Generate:** the form builds a detailed prompt (budget rules, vehicle-specific fuel/EV logic, accommodation rules, safety and traffic advice) and asks Gemini to reply **only in a fixed JSON schema**.
5. **Display:** the JSON is parsed into cards for cost, route chips, tourist stops, hotels, fuel/charging stops and Smart Advisor tips. Tapping any place opens **Google Maps**.
6. **Save:** each plan is stored per user in **Cloud Firestore** and shown later under *History → Past Plans*.
7. **Weather:** the route stops are passed to the Weather tab, which fetches live data from **OpenWeatherMap**.
8. **Expenses:** items are added with amount and split, shown in an **fl_chart** breakdown and saved to history.
9. **Tools:** the Packing Checklist (saved on the device with `shared_preferences`) and the Budget Splitter (weighted shares) work offline.

---

## ✨ Features

| | Feature | Details |
|---|---|---|
| 🔐 | **Authentication** | Firebase email/password, email verification, OTP password reset |
| 🤖 | **AI Trip Planner** | Gemini 2.5 Flash, structured JSON output, budget-aware |
| 🚗 | **Vehicle-aware** | Bike / Car / EV, with fuel stations or EV charging stops |
| 💸 | **Cost Estimate** | Fuel, food, stay and activities in INR |
| 🛡️ | **Smart Advisor** | Rain-safety routes, traffic timing, budget tips |
| 📍 | **Auto Location** | GPS → city name |
| ⛅ | **Route Weather** | Live weather for every stop |
| 📊 | **Expense Tracker** | Category charts plus per-person split |
| 💡 | **Trip Suggestions** | AI destination ideas |
| ✅ | **Packing Checklist** 🆕 | Categories, animated progress, swipe-to-delete, saved on device |
| 👥 | **Budget Splitter** 🆕 | Equal or weighted shares per traveller |
| ✨ | **Animated Splash** 🆕 | Elastic logo, slide and fade text, fade transition |
| 🌗 | **Dark Mode** 🆕 | Material 3 theme that follows the system |
| 🕘 | **History** | Past plans and expenses per user |

## 🚀 What's new in v2.0

- ✨ **Animated splash screen** (`lib/screens/splash_screen.dart`)
- ✅ **Packing Checklist** (`lib/screens/packing_checklist_screen.dart`)
- 👥 **Budget Splitter** (`lib/screens/budget_splitter_screen.dart`)
- 🎨 **Material 3 redesign:** Poppins font, rounded inputs, floating snackbars, Cupertino-style page transitions
- 🌗 **Dark mode** support
- 🔒 **No secrets in code:** API keys come in through `--dart-define`; Firebase config is git-ignored
- 🧯 Friendly error when the Gemini key is missing
- 🏷️ Rebranded to **Travel Plan** on Android, iOS and Web
- 🧪 Replaced the broken default counter test

---

## 🏗️ Tech Stack

| Layer | Tech |
|---|---|
| UI | Flutter · Material 3 · Google Fonts (Poppins) |
| AI | `google_generative_ai`, Gemini 2.5 Flash |
| Auth & DB | Firebase Auth · Cloud Firestore |
| Location | `geolocator` · `geocoding` |
| Weather | OpenWeatherMap REST API (`http`) |
| Charts | `fl_chart` |
| Local storage | `shared_preferences` |
| Links | `url_launcher` (Google Maps) |

## 📁 Project Structure

```
lib/
├── main.dart                        # App entry, theme, home tabs, AI planner
├── config.dart                      # App name/version + API keys (dart-define)
├── auth_service.dart                # Firebase auth helpers
├── login_screen.dart                # Login · Sign up · OTP reset
├── weather_screen.dart              # Route weather
├── expense_tab.dart                 # Expense tracker + charts
├── expenses_history_screen.dart     # Past expenses
├── plans_history_screen.dart        # Past plans
├── trip_suggestions_screen.dart     # AI destination ideas
└── screens/
    ├── splash_screen.dart           # 🆕 Animated splash
    ├── packing_checklist_screen.dart# 🆕 Packing checklist
    └── budget_splitter_screen.dart  # 🆕 Budget splitter
screenshots/                         # README images, banner & demo GIF
env.example.json                     # Template for API keys
```

---

## 🛠️ Setup & Run

**1. Prerequisites:** Flutter 3.35+, a Firebase project (enable **Email/Password** auth and **Firestore**), a [Gemini API key](https://aistudio.google.com/app/apikey) and an [OpenWeatherMap key](https://openweathermap.org/api).

**2. Clone & install**
```bash
git clone https://github.com/nvaltryek-001/Travel_Plan.git
cd Travel_Plan
flutter pub get
```

**3. Connect Firebase**
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

**4. Add your API keys**
```bash
cp env.example.json env.json   # put real keys inside (git-ignored)
```

**5. Run / build**
```bash
flutter run --dart-define-from-file=env.json
flutter build apk --release --dart-define-from-file=env.json
```

**6. Test**
```bash
flutter test
```

---

## 🔑 Demo Login

Create this account once in **your** Firebase project (in-app **Sign Up**, or *Firebase Console → Authentication → Add user*):

| Field | Value |
|---|---|
| 📧 **Email** | `demo.travelplan@gmail.com` |
| 🔒 **Password** | `Travel@123` |

> If email verification blocks login during a demo, verify the address or add the user from the Firebase Console.

---

## 🗺️ Roadmap

- [ ] Offline map of the planned route
- [ ] Share a trip plan as PDF
- [ ] Multi-currency expense support
- [ ] Group trips with shared Firestore plans

## 🙏 Credits

Built on [smart_travel_app](https://github.com/itsvishwasj/smart_travel_app) by **itsvishwasj**, extended with new features, a redesigned UI, dark mode, secure key handling and full documentation.

<p align="center">Made with ❤️ and Flutter</p>
