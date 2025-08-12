Flutter Counter App with Authentication
A Flutter application with user authentication and counter functionality using Riverpod state management, clean architecture, and feature-first approach.
🏗️ Architecture
The project follows Clean Architecture principles with a feature-first approach:
lib/
├── core/
│   ├── database/
│   │   └── database_helper.dart
│   ├── error/
│   │   └── failures.dart
│   ├── router/
│   │   └── app_router.dart
│   └── utils/
│       └── validators.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       └── signup_usecase.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── signup_page.dart
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       └── widgets/
│   │           └── auth_text_field.dart
│   └── counter/
│       ├── data/
│       │   └── repositories/
│       │       └── counter_repository_impl.dart
│       ├── domain/
│       │   ├── repositories/
│       │   │   └── counter_repository.dart
│       │   └── usecases/
│       │       ├── decrement_counter_usecase.dart
│       │       ├── increment_counter_usecase.dart
│       │       └── reset_counter_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   └── counter_page.dart
│           └── providers/
│               └── counter_provider.dart
└── main.dart
📱 Features

User Authentication: Sign up and login functionality
Local Database: SQLite for user data storage
Counter Management: Increment, decrement, and reset counter
State Management: Riverpod for reactive state management
Clean Architecture: Separation of concerns with feature-first approach
Input Validation: Email and password validation
Navigation: Go Router for routing

🛠️ Tech Stack

Flutter: UI framework
Riverpod: State management
SQLite: Local database (sqflite package)
Go Router: Navigation
Crypto: Password hashing

📦 Dependencies
Add these dependencies to your pubspec.yaml:
yamldependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  go_router: ^12.1.3
  sqflite: ^2.3.0
  crypto: ^3.0.3
  path: ^1.8.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
🚀 Getting Started

Clone the repository
Run flutter pub get to install dependencies
Run flutter run to start the app

📱 App Flow

Splash/Login Page: Users can login or navigate to signup
Signup Page: New users can create an account
Counter Page: Authenticated users can interact with the counter

🔧 Key Components
Authentication

Local SQLite database for user storage
Password hashing for security
Form validation for email and password

Counter

Simple counter with three operations
State managed by Riverpod
Persistent across app sessions

State Management

Riverpod providers for both auth and counter states
Clean separation between UI and business logic
Reactive UI updates

📝 Usage
Sign Up

Enter email and password
Confirm password
Account created and automatically logged in

Login

Enter existing email and password
Validation and authentication
Navigate to counter page

Counter Operations

Increment: Tap the "+" button
Decrement: Tap the "-" button
Reset: Tap the "Reset" button

🏛️ Architecture Details
Clean Architecture Layers

Presentation Layer: UI components, pages, and providers
Domain Layer: Business logic, entities, and use cases
Data Layer: Data sources, repositories, and models

Feature-First Approach
Each feature (auth, counter) contains all its layers, promoting:

Better organization
Easier testing
Clear feature boundaries
Independent development

This architecture ensures maintainable, testable, and scalable code following Flutter and Dart best practices.
