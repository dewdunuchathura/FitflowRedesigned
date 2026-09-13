# FitFlow – AI Microservice

**Technology: Python + FastAPI**

## Overview

This directory contains the AI microservice for FitFlow. It is a dedicated, independently deployable service responsible for AI/ML-powered features such as personalized workout recommendations, nutrition insights, and exercise suggestions. The main NestJS backend communicates with this service through a REST API.

## Why Python + FastAPI

- Python has the richest AI/ML ecosystem: TensorFlow, PyTorch, scikit-learn, Hugging Face
- FastAPI provides high-performance async REST endpoints with automatic OpenAPI documentation
- Separation of concerns: AI logic is isolated from core business logic
- Independent deployment and scaling — the AI service can scale separately from the main backend
- Easier for data science and ML specialists to contribute without touching the main backend

## Responsibilities

- Personalized workout plan generation based on user fitness data
- Exercise recommendations tailored to user goals and history
- Nutrition recommendations based on tracked intake and targets
- Fitness progress insights and trend analysis
- Prediction and recommendation model inference

## Communication

```
NestJS Backend  →  HTTP REST  →  FastAPI AI Service
FastAPI AI Service  →  HTTP Response  →  NestJS Backend
```

## Planned Structure

```
ai-service/
├── app/
│   ├── main.py           # FastAPI entry point
│   ├── routers/
│   │   ├── workouts.py   # Workout recommendation endpoints
│   │   ├── nutrition.py  # Nutrition recommendation endpoints
│   │   └── insights.py   # Progress insights endpoints
│   ├── models/           # ML model loading and inference
│   └── schemas/          # Pydantic request/response schemas
├── requirements.txt
├── Dockerfile
└── README.md
```

## Setup (Placeholder)

```bash
pip install -r requirements.txt
uvicorn app.main:app --reload
```

> Note: Actual implementation is out of scope for IT3060 Lab Exercise 05.
> This folder represents the planned AI microservice component of the FitFlow architecture.
