# FitFlow – Backend

**Technology: Node.js + NestJS**

## Overview

This directory contains the main backend API for FitFlow, built with Node.js and the NestJS framework. NestJS provides a modular, opinionated architecture that scales well for mid-sized applications and supports both REST and WebSocket communication.

## Why Node.js + NestJS

- TypeScript-first development with strong typing
- Modular architecture with clear separation of concerns (modules, controllers, services, guards)
- Built-in support for REST APIs and WebSockets (via `@nestjs/websockets` + Socket.IO)
- Excellent integration with PostgreSQL (TypeORM or Prisma)
- Redis integration for caching and session management
- Middleware, interceptors, and guards for authentication and authorization
- Good ecosystem for a mid-sized development team
- Scalable and maintainable under continued development

## Planned Structure

```
backend/
├── src/
│   ├── app.module.ts
│   ├── main.ts
│   ├── auth/             # Firebase Auth validation, JWT handling
│   ├── users/            # User profile management
│   ├── workouts/         # Workout plans and exercises
│   ├── nutrition/        # Nutrition records and summaries
│   ├── social/           # Social posts, follows, feed
│   ├── ai/               # Integration with FastAPI AI service
│   ├── realtime/         # WebSocket gateway (Socket.IO)
│   └── common/           # Guards, interceptors, filters, decorators
├── test/
├── package.json
├── tsconfig.json
└── README.md
```

## Setup (Placeholder)

```bash
npm install
npm run start:dev
```

Environment variables required (see `.env.example`):

```
DATABASE_URL=
REDIS_URL=
FIREBASE_PROJECT_ID=
AI_SERVICE_URL=
```

> Note: Actual implementation is out of scope for IT3060 Lab Exercise 05.
> This folder represents the planned backend component of the FitFlow architecture.
