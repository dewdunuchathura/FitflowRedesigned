# FitFlow – Frontend

**Technology: Flutter**

## Overview

This directory contains the Flutter frontend application for FitFlow. Flutter provides a single codebase that compiles to native iOS, Android, and Web targets, satisfying FitFlow's requirement to support all three platforms without maintaining separate codebases.

## Why Flutter

- Single Dart codebase for iOS, Android, and Web
- Compiled to native ARM code — no JavaScript bridge overhead
- Rich widget library with consistent UI across platforms
- Strong support for animations, custom UI components, and responsive layouts
- Good integration with REST APIs, WebSockets, and Firebase Authentication
- Active ecosystem and community

## Planned Structure

```
frontend/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── api/          # REST API clients
│   │   ├── auth/         # Firebase Auth integration
│   │   └── socket/       # WebSocket / Socket.IO client
│   ├── features/
│   │   ├── auth/         # Login, registration, profile
│   │   ├── workout/      # Workout plans and tracking
│   │   ├── nutrition/    # Nutrition logging and summaries
│   │   └── social/       # Social feed and sharing
│   └── shared/
│       ├── widgets/      # Reusable UI components
│       └── theme/        # App theme and design tokens
├── test/
├── pubspec.yaml
└── README.md
```

## Setup (Placeholder)

```bash
flutter pub get
flutter run
```

> Note: Actual implementation is out of scope for IT3060 Lab Exercise 05.
> This folder represents the planned frontend component of the FitFlow architecture.
