# Activity 4 – High-Level System Architecture

**IT3060 – Human Computer Interaction | Lab Exercise 05**

---

## 1. Architecture Overview

The FitFlow system follows a **layered, service-oriented architecture** that separates concerns across clearly defined components. The architecture is designed to be:

- **Scalable** — individual components can be scaled independently
- **Maintainable** — each service has a clear responsibility and defined API boundary
- **Secure** — authentication and authorization are enforced at every layer
- **Extensible** — new services can be integrated without modifying existing components

### Core Components

| Component              | Technology                  | Role                                             |
|------------------------|-----------------------------|--------------------------------------------------|
| Flutter Frontend       | Flutter (Dart)              | iOS, Android, and Web client application         |
| Authentication         | Firebase Authentication     | User identity verification and token issuance   |
| Main Backend           | Node.js + NestJS            | Business logic, REST API, WebSocket gateway      |
| Primary Database       | PostgreSQL                  | Persistent storage for all structured data       |
| Cache                  | Redis                       | Temporary data, session caching, rate limiting   |
| AI Microservice        | Python + FastAPI            | Personalized recommendations and ML inference    |
| Real-time Layer        | WebSockets / Socket.IO      | Live event delivery to connected clients         |

---

## 2. Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      FitFlow User                           │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                   Flutter Frontend                          │
│              iOS  │  Android  │  Web                        │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Auth    │  │ Workout  │  │Nutrition │  │  Social  │  │
│  │  Module  │  │  Module  │  │  Module  │  │  Module  │  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │
└───────────────────────────┬────────────┬────────────────────┘
                            │ HTTPS/REST │ WebSocket
              ┌─────────────┘            └──────────────┐
              ▼                                          ▼
┌───────────────────────┐               ┌───────────────────────┐
│  Firebase             │               │  NestJS Backend       │
│  Authentication       │               │                       │
│                       │               │  ┌─────────────────┐  │
│  - JWT token issue    │◄──────────────│  │  Auth Guard     │  │
│  - Social login       │  Token verify │  │  (JWT validation│  │
│  - Google / Apple     │               │  └─────────────────┘  │
│  - Email / password   │               │  ┌─────────────────┐  │
└───────────────────────┘               │  │  REST API       │  │
                                        │  │  Controllers    │  │
                                        │  └─────────────────┘  │
                                        │  ┌─────────────────┐  │
                                        │  │  WebSocket      │  │
                                        │  │  Gateway        │  │
                                        │  └─────────────────┘  │
                                        │  ┌─────────────────┐  │
                                        │  │  Business Logic │  │
                                        │  │  Services       │  │
                                        │  └─────────────────┘  │
                                        └─────────┬─────────────┘
                                                  │
                    ┌─────────────────────────────┼────────────────────────────┐
                    │                             │                            │
                    ▼                             ▼                            ▼
     ┌──────────────────────┐     ┌──────────────────────┐    ┌──────────────────────┐
     │      PostgreSQL      │     │        Redis         │    │  Python + FastAPI    │
     │  Primary Database    │     │   Cache / Sessions   │    │  AI Microservice     │
     │                      │     │                      │    │                      │
     │  - Users             │     │  - Workout plan cache│    │  - Workout recs.     │
     │  - Workout plans     │     │  - Session tokens    │    │  - Nutrition recs.   │
     │  - Exercises         │     │  - API response cache│    │  - Progress insights │
     │  - Nutrition records │     │  - Rate limit counts │    │  - ML model inference│
     │  - Social posts      │     │  - AI result cache   │    │                      │
     │  - Progress records  │     │                      │    └──────────────────────┘
     │  - Follows           │     └──────────────────────┘
     └──────────────────────┘
```

---

## 3. Component Communication

### 3.1 Communication Protocols

| Connection                        | Protocol          | Notes                                         |
|-----------------------------------|-------------------|-----------------------------------------------|
| Flutter → Firebase Auth           | HTTPS (Firebase SDK) | Token acquisition and social login          |
| Flutter → NestJS (standard ops)   | HTTPS / REST      | CRUD operations, data retrieval               |
| Flutter ↔ NestJS (real-time)      | WebSocket (Socket.IO) | Live events, notifications, social updates |
| NestJS → Firebase Auth            | HTTPS (Firebase Admin SDK) | JWT token verification on every request |
| NestJS → PostgreSQL               | TCP (PostgreSQL protocol) | ORM queries (TypeORM or Prisma)          |
| NestJS → Redis                    | TCP (Redis protocol) | Cache reads/writes, rate limiting           |
| NestJS → FastAPI AI Service       | HTTPS / REST      | Internal API call for AI recommendations      |
| FastAPI → ML Models               | In-process        | Model inference within the Python runtime     |

### 3.2 Authentication Flow

```
1. User opens FitFlow on Flutter (iOS/Android/Web)
2. Flutter calls Firebase Authentication (social login or email/password)
3. Firebase issues a signed JWT (ID token)
4. Flutter includes the JWT in the Authorization header on every NestJS API request
5. NestJS Auth Guard verifies the JWT using Firebase Admin SDK
6. If valid, the request proceeds; if invalid, 401 Unauthorized is returned
7. NestJS RBAC guard checks role-based permissions for the specific endpoint
```

---

## 4. Critical Data Flows

### 4.1 Flow 1 — Personalized Workout Plan Generation

```
Step 1:  User opens the Workout Plan section in Flutter
Step 2:  Flutter sends GET /api/workouts/recommendations to NestJS (HTTPS + JWT)
Step 3:  NestJS Auth Guard validates the JWT token
Step 4:  NestJS WorkoutsService retrieves the user's profile, history, and
         preferences from PostgreSQL
Step 5:  NestJS sends a POST request to the FastAPI AI service with the
         user data (fitness level, goals, available equipment, recent workouts)
Step 6:  FastAPI processes the data through the ML recommendation model
Step 7:  FastAPI returns a personalized workout plan to NestJS
Step 8:  NestJS saves the generated plan to PostgreSQL
Step 9:  NestJS writes the plan to Redis cache (TTL-based) to reduce
         repeat computation on subsequent requests
Step 10: NestJS returns the plan to Flutter
Step 11: Flutter renders the personalized workout plan for the user
```

**Sequence Diagram:**

```
Flutter       NestJS        PostgreSQL    Redis         FastAPI AI
  │              │               │           │               │
  │──GET /recs──►│               │           │               │
  │              │──Verify JWT   │           │               │
  │              │──Fetch user──►│           │               │
  │              │◄──User data───│           │               │
  │              │──Check cache─────────────►│               │
  │              │◄──Cache miss──────────────│               │
  │              │──POST /recommend──────────────────────────►│
  │              │◄──Workout plan────────────────────────────│
  │              │──Save plan───►│           │               │
  │              │──Cache plan──────────────►│               │
  │◄──Plan data──│               │           │               │
```

---

### 4.2 Flow 2 — Social Sharing (Workout Post)

```
Step 1:  User completes a workout and creates a social post in Flutter
Step 2:  Flutter sends POST /api/social/posts to NestJS (HTTPS + JWT)
Step 3:  NestJS Auth Guard validates authentication
Step 4:  NestJS authorization guard confirms the user has the required role
Step 5:  NestJS validates the post content (input validation via class-validator)
Step 6:  NestJS SocialService saves the post to PostgreSQL
Step 7:  NestJS queries PostgreSQL for the user's followers
Step 8:  NestJS WebSocket Gateway emits a 'new_post' event to all connected
         followers via Socket.IO
Step 9:  Flutter (on each follower's device) receives the WebSocket event
Step 10: Flutter updates the social feed in real time for connected followers
Step 11: Offline followers receive the post on their next feed refresh via REST
```

---

### 4.3 Flow 3 — Nutrition Tracking

```
Step 1:  User logs a meal in Flutter (food item, quantity, timestamp)
Step 2:  Flutter sends POST /api/nutrition/logs to NestJS (HTTPS + JWT)
Step 3:  NestJS validates the JWT and nutrition data (quantities within range,
         required fields present)
Step 4:  NestJS NutritionService saves the nutrition record to PostgreSQL
         linked to the authenticated user and the current date
Step 5:  NestJS calculates the daily nutrition summary (calories, macros)
         from the updated records
Step 6:  Frequently accessed summaries (e.g., weekly averages) are cached
         in Redis to reduce repeated database computation
Step 7:  NestJS optionally triggers an AI recommendation request to FastAPI
         if the user's nutritional intake deviates significantly from their
         target (async, non-blocking)
Step 8:  NestJS returns the updated daily nutrition summary to Flutter
Step 9:  Flutter displays the updated nutrition dashboard with progress rings
```

---

## 5. Security Architecture

### 5.1 Authentication

Firebase Authentication handles user identity verification. Every API request from Flutter must include a valid Firebase JWT in the Authorization header:

```
Authorization: Bearer <firebase-jwt-token>
```

The NestJS Auth Guard verifies this token using the Firebase Admin SDK on every protected request. Expired or tampered tokens are rejected with a 401 Unauthorized response.

### 5.2 Authorization (Role-Based Access Control)

NestJS implements role-based authorization through custom guards applied at the controller or route level.

| Role          | Permissions                                                        |
|---------------|--------------------------------------------------------------------|
| User          | Manage own profile, workouts, nutrition, and social activity       |
| Trainer       | View assigned clients' progress; create and assign workout plans   |
| Administrator | Full system access; user management; content moderation            |

Authorization example:

```typescript
@Get('admin/users')
@Roles(Role.Administrator)
@UseGuards(FirebaseAuthGuard, RolesGuard)
getAllUsers() { ... }
```

### 5.3 Transport Security

All communication between Flutter and NestJS is encrypted via **HTTPS/TLS**. WebSocket connections are established over **WSS** (WebSocket Secure). Internal service communication (NestJS → FastAPI, NestJS → PostgreSQL, NestJS → Redis) operates on private network interfaces where possible.

### 5.4 Input Validation

NestJS uses `class-validator` and `class-transformer` to validate and sanitize all incoming data at the API boundary. Malformed requests are rejected before reaching service logic. FastAPI uses Pydantic schemas for the same purpose on the AI service boundary.

### 5.5 Rate Limiting

`@nestjs/throttler` is applied to all public and authenticated endpoints to protect against excessive requests, brute-force attacks, and denial-of-service patterns. Rate limit counts are stored in Redis for efficiency.

### 5.6 Secrets Management

No API keys, database credentials, or service tokens are hard-coded in the application source. All secrets are managed through environment variables (`.env` files, excluded from version control) or a secrets management service in production (e.g., cloud provider secret manager).

### 5.7 Encryption at Rest

Database encryption at rest is enabled at the PostgreSQL storage layer. Firebase Authentication tokens are short-lived JWTs. Sensitive user health data fields can be encrypted at the application layer as an additional safeguard.

### 5.8 Audit Logging

Authentication events (login, logout, failed attempts), data access on sensitive records, and administrative actions are logged with timestamps and user identifiers for security auditing.

---

## 6. Scalability

### 6.1 Horizontal Backend Scaling

The NestJS backend is designed to be **stateless**. Session state is stored in Redis rather than in process memory, enabling multiple instances of the backend to run behind a load balancer without session affinity requirements.

```
Load Balancer
      │
      ├── NestJS Instance 1
      ├── NestJS Instance 2
      └── NestJS Instance N
              │
          Redis (shared state)
              │
          PostgreSQL (shared data)
```

### 6.2 Database Scaling

PostgreSQL scales vertically for the initial growth phase. For read-heavy workloads, **read replicas** can be added. For horizontal scaling beyond a single primary, **Citus** (PostgreSQL extension) or a managed cloud PostgreSQL service with sharding support can be adopted.

### 6.3 Redis Caching

Redis reduces database load by caching:
- Frequently requested workout plans (TTL-based expiry)
- Daily/weekly nutrition summaries
- AI recommendation results (avoiding repeated model inference for unchanged inputs)
- Rate limiting counters

### 6.4 AI Service Scaling

The FastAPI AI service can be **scaled independently** from the main NestJS backend. If AI recommendation demand increases, additional FastAPI instances can be deployed without modifying the backend. GPU-enabled compute instances can be allocated exclusively to the AI service.

### 6.5 WebSocket Scaling

For WebSocket scaling across multiple NestJS instances, Socket.IO supports a **Redis adapter** that coordinates event delivery across instances. This ensures that a WebSocket event emitted from Instance 1 reaches clients connected to Instance 2.

---

## 7. Integration

### 7.1 Integration Map

```
Flutter
  ├── Firebase Authentication (SDK) — user login and token management
  ├── NestJS REST API (HTTPS) — all data operations
  └── NestJS WebSocket (WSS/Socket.IO) — real-time events

NestJS Backend
  ├── Firebase Admin SDK (HTTPS) — JWT verification
  ├── PostgreSQL (TypeORM/Prisma) — primary data storage
  ├── Redis (ioredis) — caching and rate limiting
  └── FastAPI AI Service (HTTPS/REST) — recommendation requests

FastAPI AI Service
  └── PostgreSQL (optional, read-only) — historical data for model training
```

### 7.2 REST API Design

The NestJS REST API follows RESTful conventions:

| Method | Endpoint                        | Action                              |
|--------|---------------------------------|-------------------------------------|
| POST   | /api/auth/verify                | Verify Firebase JWT and return user |
| GET    | /api/users/:id                  | Get user profile                    |
| GET    | /api/workouts/recommendations   | Get personalized workout plan       |
| POST   | /api/workouts/logs              | Log a completed workout             |
| POST   | /api/nutrition/logs             | Log a meal entry                    |
| GET    | /api/nutrition/summary          | Get daily/weekly nutrition summary  |
| GET    | /api/social/feed                | Get social activity feed            |
| POST   | /api/social/posts               | Create a social post                |

### 7.3 WebSocket Events

| Event (server → client) | Payload        | Trigger                              |
|--------------------------|----------------|--------------------------------------|
| `new_post`               | Post object    | A followed user creates a post        |
| `workout_complete`       | Workout summary| A followed user completes a workout   |
| `new_follower`           | User summary   | A new user follows the current user   |
| `notification`           | Notification   | Goal achieved, reminder, system alert |

---

## 8. Maintainability

### 8.1 Modular NestJS Architecture

NestJS enforces a modular structure. Each feature domain is encapsulated in a module with its own controller, service, and data access layer:

```
src/
├── auth/         # Authentication module
├── users/        # User profile module
├── workouts/     # Workout plans and logging module
├── nutrition/    # Nutrition tracking module
├── social/       # Social features module
├── ai/           # AI service integration module
└── common/       # Shared guards, interceptors, filters
```

Each module is independently testable. Changes to the nutrition module do not affect the workout module.

### 8.2 Database Schema Management

Schema changes are managed through versioned migration files using TypeORM Migrations or Prisma Migrate. Every schema change is committed to version control, making the database history auditable and reproducible.

### 8.3 Shared Frontend Code

Flutter's single Dart codebase ensures that all platforms share the same UI components, business logic, and API client code. There is no risk of platform-specific UI drift.

### 8.4 Testing Strategy

| Layer         | Testing Approach                                       |
|---------------|--------------------------------------------------------|
| Flutter       | Unit tests (business logic); widget tests (UI components) |
| NestJS        | Unit tests (services); integration tests (controllers + DB) |
| FastAPI AI    | Unit tests (model outputs); integration tests (API endpoints) |
| PostgreSQL    | Migration tests; query performance tests               |

---

## 9. Architecture Decision Record

See [ADR-001-technology-stack.md](ADR-001-technology-stack.md) for the formal Architecture Decision Record documenting the technology selection rationale.

---

*Document: Activity 4 – High-Level System Architecture*
*Course: IT3060 Human Computer Interaction | Lab Exercise 05*
