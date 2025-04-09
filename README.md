# CheckMate

CheckMate is a GPS-based attendance tracking system that enables employees or managers to check in/out from designated locations to register their attendance.                               
It provides real-time attendance tracking, user management, and leaves management.

# Features

- **GPS-Based Attendance**: Employees can check in/out only within specified locations.
- **Leaves Management**: Employees can request leaves, and admins can approve or reject.
- **Authentication**: Firebase-based login with Email and Password.
- **Real-Time Tracking**: HR managers (Admins) can monitor all employees attendance in realtime.
- **Localization**: Supports multiple languages for a better user experience.
- **User Management**: Admin can add new employee and his role from the dashboard.
- **Leave Balance**: Every employee can check/track his leave balance and his leaves requests.
- **Theme feature**: The user can toggle between light and dark theme modes.

--------------------------------------------------

# User Roles

The application contains three user roles:
- **Employee role.**
- **Manager role.**
- **Admin role.**

**The Role of each user:**                                                               
- The Employee/Manager can checkin/checkout, view his leaves requests, request a leave, track his attendance data.                                                         
- The Admin manages users, add every user with his specified role in the system, and track all users attendance in real time from his dashboard.                                          
- When The Employee/manager logins to the app, he will be redirected to the Home layout page.                                                      
- This layout includes check-in page to checking, leaves page include user leaves, and profile page.                                            
- When the admin logins to the app, he will be redirected to the admin dashboard layout for tracking Attendance and leaves requests.

-------------------------------------------------------

# System Components (Tech-stack)
- **Frontend: Flutter (Dart)**
    - **User View**: (home layout includes check in, profile, and leaves pages).
    - **Admin View**: (Admin dashboard in mobile design (the same app) for tracking Attendance Records and manage leaves requests).
- **Backend:** Firebase (Firestore, Authentication)
- **State Management:** BLoC State Management.
- **GPS Services:** Google Maps API.

------------------------------------------------
# Getting Started

There is 3 Flavors for this app:
- staging
- development
- production

## staging
$ flutter run --flavor staging --target lib/main_staging.dart

## development
$ flutter run --flavor development --target lib/main_development.dart

## production
$ flutter run --flavor production --target lib/main_production.dart

---------------------------------------------

# How to Run

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the app.

------------------------------------------------

# Packages Used
This project uses the following **Flutter packages**:

### ✅ Core Dependencies
- [`bloc`](https://pub.dev/packages/bloc) - State management using BLoC pattern.
- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) - Integration of BLoC with Flutter widgets.
- [`equatable`](https://pub.dev/packages/equatable) - Simplifies state comparisons in BLoC.
- [`firebase_core`](https://pub.dev/packages/firebase_core) - Connects the app to Firebase.
- [`firebase_auth`](https://pub.dev/packages/firebase_auth) - Handles user authentication.
- [`cloud_firestore`](https://pub.dev/packages/cloud_firestore) - NoSQL database for storing app data.
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) - Local storage for lightweight data.
- [`intl`](https://pub.dev/packages/intl) - Internationalization and date formatting.
- [`uuid`](https://pub.dev/packages/uuid) - Generates unique IDs.

### 📍 Location & Maps
- [`geolocator`](https://pub.dev/packages/geolocator) - Access user location and GPS data.
- [`google_maps_flutter`](https://pub.dev/packages/google_maps_flutter) - Embeds Google Maps into the app.

### 🎨 UI & Utilities
- [`calendar_timeline`](https://pub.dev/packages/calendar_timeline) - Displays a horizontal calendar widget.
- [`skeletonizer`](https://pub.dev/packages/skeletonizer) - Shows loading skeleton placeholders.

### 🛠 Development & Testing
- [`bloc_test`](https://pub.dev/packages/bloc_test) - Testing utilities for BLoC.
- [`mocktail`](https://pub.dev/packages/mocktail) - Mocking framework for unit tests.
- [`build_runner`](https://pub.dev/packages/build_runner) - Code generation utilities.
- [`very_good_analysis`](https://pub.dev/packages/very_good_analysis) - Linting and best practices enforcement.
- [`flutter_test`](https://pub.dev/packages/flutter_test) - Built-in Flutter testing framework.
