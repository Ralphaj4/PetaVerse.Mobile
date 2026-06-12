# CLAUDE.md

# PetCare Mobile App - Flutter Engineering Guidelines

## Overview

This project is a Flutter mobile application for a comprehensive pet ecosystem platform.

The application will eventually support:

* Pet Health Management
* Medical Records
* Vaccination Tracking
* Medication Reminders
* Appointment Scheduling
* AI Pet Assistant
* Lost Pet Platform
* GPS Tracking
* Social Network
* Marketplace
* Smart Devices
* Emergency Services

This document defines mandatory engineering standards that Claude Code must follow when generating code.

---

# Technology Stack

## Flutter

Latest Stable Version

## State Management

Riverpod

Required Packages:

* flutter_riverpod
* riverpod_annotation

Do not use:

* Provider
* GetX
* MobX
* Bloc

---

## Navigation

Use:

go_router

Do not use:

* Navigator.push
* Navigator.pop directly in feature code

Navigation must be routed through GoRouter.

Every GoRoute must use pageBuilder with AppTransitionPage
(lib/core/app/router/app_transition_page.dart) so the whole app shares
one navigation animation. Never use the default builder.

---

## Networking

Use:

dio

Never call Dio directly from UI.

Always use:

Repository
→ DataSource
→ ApiClient

---

## Model Generation

Use:

* freezed
* json_serializable

All DTOs must be immutable.

---

## Local Storage

Use:

Hive

For:

* Cached Data
* Offline Data

Never store:

* JWT Tokens
* Refresh Tokens
* Secrets

---

## Secure Storage

Use:

flutter_secure_storage

Store:

* Access Tokens
* Refresh Tokens
* Sensitive Information

---

## Notifications

Use:

firebase_messaging

---

## Analytics

Use:

firebase_analytics

---

## Crash Reporting

Use:

firebase_crashlytics

---

# Architecture

Use Feature First Clean Architecture.

Project Structure:

lib/

core/
shared/
features/

---

# Core Structure

lib/core

Contains:

core/

app/
network/
storage/
theme/
localization/
errors/
analytics/
constants/
extensions/
utils/
widgets/

Core must never depend on feature modules.

---

# Shared Structure

shared/

Contains reusable components:

shared/

widgets/
models/
enums/

Shared must contain no business logic.

---

# Feature Structure

Each feature must follow:

features/

feature_name/

data/
domain/
presentation/

---

# Data Layer

features/

feature/

data/

datasources/
dtos/
repositories/

Responsibilities:

* API Calls
* DTO Mapping
* Data Persistence

No UI logic.

---

# Domain Layer

features/

feature/

domain/

entities/
repositories/
usecases/

Responsibilities:

* Business Rules
* Contracts
* Use Cases

No Flutter imports allowed.

---

# Presentation Layer

features/

feature/

presentation/

pages/
widgets/
providers/
states/

Responsibilities:

* UI
* User Interactions
* State Management

No API calls allowed.

---

# State Management Rules

Use Riverpod.

Approved Providers:

* Provider
* FutureProvider
* StreamProvider
* AsyncNotifierProvider
* NotifierProvider

Avoid global state unless absolutely necessary.

Feature state belongs inside the feature.

---

# Async State Pattern

Always use AsyncValue.

Example States:

Loading

Data

Error

Never create custom loading booleans.

Avoid:

bool isLoading

Prefer:

AsyncValue<T>

---

# Error Handling

Never swallow exceptions.

All repository methods must return:

Result<T>

or

Either<Failure, T>

Failure Types:

* NetworkFailure
* UnauthorizedFailure
* ForbiddenFailure
* ValidationFailure
* ServerFailure
* UnknownFailure

Never throw raw exceptions to UI.

---

# API Layer

Mandatory Flow:

Screen
→ Provider
→ UseCase
→ Repository
→ DataSource
→ ApiClient

Forbidden:

Screen
→ Dio

Screen
→ Repository

Screen
→ API

---

# ApiClient

Only one ApiClient may exist.

Responsibilities:

* Authentication Headers
* Token Refresh
* Logging
* Retry Policies
* Error Mapping

All requests must pass through ApiClient.

---

# Token Handling

Access Token:

flutter_secure_storage

Refresh Token:

flutter_secure_storage

Never:

* Store tokens in Hive
* Store tokens in SharedPreferences

---

# Offline First Strategy

The application must support offline mode.

Flow:

Load Cached Data
→ Show UI
→ Sync API
→ Update Cache
→ Refresh UI

Offline Support Required For:

* Pets
* Vaccinations
* Medications
* Appointments
* Medical Records

---

# Localization

Supported Languages:

* English
* Arabic
* French

Requirements:

* ARB files
* RTL Support
* No hardcoded strings

Never write:

Text("Add Pet")

Always use:

context.l10n.addPet

---

# Theme System

Use centralized themes.

No inline styling.

Forbidden:

TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
)

Create design tokens.

Example:

AppTextStyles

AppColors

AppSpacing

AppRadius

---

# Design System

Primary Color

RGB(251,171,76)

Secondary Color

RGB(1,180,194)

Border Radius

* 12
* 16
* 24

Spacing Scale

* 4
* 8
* 12
* 16
* 24
* 32

Font for the whole app
Plus Jakarta Sans

---

# Widget Rules

Prefer small widgets.

Target:

Under 200 lines per widget.

If widget exceeds 200 lines:

Extract components.

---

# Page Rules

Pages should only:

* Layout UI
* Listen to State
* Trigger Actions

Business logic must not exist inside pages.

---

# Forms

Use:

flutter_form_builder

Validation:

* Client Side
* Server Side

Validation messages must be localized.

---

# Loading States

Every async screen must support:

* Loading
* Success
* Empty
* Error

No blank screens.

---

# Empty States

Every list screen must support:

* No Data State
* Error State
* Loading State

Use reusable widgets.

---

# Search

All searchable lists must support:

* Debouncing
* Pagination

Never call API on every keystroke.

Recommended:

300ms debounce

---

# Pagination

Use Infinite Scroll.

Load:

20 items

Then:

20 more

Never load large collections.

---

# Images

Use:

cached_network_image

Requirements:

* Placeholder
* Error Widget
* Caching

---

# Icons

Use:

fluentui_system_icons

Always use FluentIcons for every icon in the app.

Prefer the 24-size variants:

* Regular variant for default/unselected states
* Filled variant for selected/active states

Never use:

* Material Icons (Icons.*)
* CupertinoIcons

---

# Accessibility

Support:

* Screen Readers
* Large Fonts
* High Contrast
* Semantic Labels

Accessibility is mandatory.

---

# Logging

Use LoggerService.

Development:

Verbose Logs

Production:

Errors Only

Never log:

* Passwords
* Tokens
* Personal Data

---

# Crash Handling

Configure:

FlutterError.onError

PlatformDispatcher.instance.onError

Send all crashes to Crashlytics.

---

# Analytics Events

Track:

PetCreated

AppointmentBooked

MedicationCompleted

VaccinationAdded

AIChatStarted

PurchaseCompleted

SOSActivated

Never track sensitive medical information.

---

# Notifications

Notification Categories:

* Medication
* Vaccination
* Appointment
* Emergency
* Social
* Marketplace

Never place all notifications into one category.

---

# Security

Requirements:

* SSL Pinning
* Secure Storage
* Certificate Validation
* Root Detection
* Jailbreak Detection

Never trust client-side data.

---

# Testing

Required Tests:

Unit Tests

Repositories

Use Cases

Providers

Widget Tests

Critical Components

Integration Tests

Critical Flows

Examples:

* Login
* Add Pet
* Add Vaccination
* Book Appointment
* AI Chat
* Marketplace Checkout

---

# Naming Conventions

Entities:

Pet

Appointment

Vaccination

DTOs:

PetDto

AppointmentDto

Providers:

petProvider

appointmentProvider

Repositories:

PetRepository

AppointmentRepository

Pages:

PetDetailsPage

AppointmentPage

Widgets:

PetCard

AppointmentCard

---

# Code Generation

Always use:

build_runner

Generated files must not be edited manually.

---

# Pull Request Checklist

Every feature must include:

* Localization
* Error Handling
* Loading State
* Empty State
* Analytics
* Unit Tests
* Widget Tests
* Documentation

---

# Definition Of Done

A feature is complete only when:

✓ UI Implemented

✓ State Management Implemented

✓ Localization Added

✓ Error Handling Added

✓ Loading States Added

✓ Empty States Added

✓ Analytics Added

✓ Tests Added

✓ Accessibility Verified

✓ Code Reviewed

Otherwise the feature is not complete.
