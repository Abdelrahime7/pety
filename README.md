# Pety+

Pety+ is a mobile application designed to help pet owners manage and monitor their pets' health information in one place.

The application allows users to manage pet profiles, store medical records, track vaccinations and medications, schedule veterinary appointments, and receive health reminders. The project is being developed for the **Shipaton 2026 hackathon**, with premium monetization handled through **RevenueCat**.

## ✨ Features

### Authentication
- Register with email and password
- Secure login
- Password reset
- User profile management

### Pet Management
Users can:
- Add and edit pets
- Upload pet photos
- Store pet information such as:
  - Name
  - Species
  - Breed
  - Gender
  - Birth date
  - Weight
  - Medical notes

### Health Tracking

#### Vaccinations
- Add vaccination records
- Store vaccine name and date
- Create vaccination reminders

#### Medications
- Track medications
- Define dosage and schedules
- Receive medication notifications

#### Appointments
- Create veterinary appointments
- Receive appointment reminders

#### Weight Tracking
- Record weight history
- Display weight progress through charts

### 💎 Premium Features
Premium subscriptions provide:
- Unlimited pets
- Cloud backup
- Family sharing
- Advanced health reports
- PDF medical record export

Subscriptions and purchases are managed through RevenueCat.

## 🛠️ Technology Stack

| Component | Technology |
|---|---|
| Mobile Application | Flutter |
| Backend | Firebase |
| Authentication | Firebase Authentication |
| Database | Cloud Firestore |
| File Storage | Firebase Storage |
| Notifications | Firebase Cloud Messaging |
| Serverless Logic | Firebase Cloud Functions |
| Subscriptions | RevenueCat |
| State Management | Riverpod |
| Architecture | Flutter Clean Architecture |

## 🏗️ Architecture

pety+ follows a **Clean Architecture** approach with Riverpod for application state management.

```text
lib/
├── core/
│   ├── services/
│   ├── constants/
│   └── utils/
│
├── features/
│   ├── authentication/
│   ├── pets/
│   ├── health/
│   ├── appointments/
│   └── subscription/
│
├── presentation/
├── domain/
└── data/
```

## ☁️ Firebase Architecture

### Firebase Authentication
Used for:
- User identity
- Secure login
- Account management

### Cloud Firestore
Stores:
- User data
- Pet profiles
- Health records
- Appointments

### Firebase Storage
Used for:
- Pet images
- Medical documents

### Firebase Cloud Messaging
Used for:
- Health reminders
- Appointment notifications

### Cloud Functions
Used for:
- Scheduled reminders
- RevenueCat webhook processing

## 🗄️ Data Model

The main Firestore collections are:

```text
users
├── userId
├── email
├── name
├── photoUrl
├── subscriptionStatus
└── createdAt

pets
├── petId
├── ownerId
├── name
├── species
├── breed
├── gender
├── birthDate
├── weight
└── photoUrl

healthRecords
├── recordId
├── petId
├── type
├── title
├── date
└── notes

appointments
├── appointmentId
├── petId
├── date
├── veterinarian
└── notes

notifications
├── notificationId
├── userId
├── title
├── message
└── status
```

## 💳 Subscription Flow

Pety uses RevenueCat for premium subscriptions.

```text
User selects premium plan
        ↓
App Store / Google Play processes payment
        ↓
RevenueCat verifies purchase
        ↓
Firebase updates subscription status
        ↓
Premium features become available
```

## 🔐 Security

The application is designed to:
- Protect user data with Firebase Authentication
- Restrict users to their own pets and data
- Encrypt sensitive information
- Validate user input
- Use Firebase Security Rules

## ⚡ Non-Functional Requirements

### Performance
- Fast application loading
- Offline data caching
- Support for multiple pets per account

### Reliability
- Firebase data synchronization
- Automatic backup

### Usability
- Simple interface
- Mobile-first design
- Accessible navigation

### Scalability
Firebase services provide the infrastructure needed to scale the application to thousands of users.

## 🚀 Future Improvements

Possible future features include:
- AI pet care assistant
- Lost pet tracking
- Smart collar integration
- Veterinary portal
- AI-based health prediction

## 🎯 Project Goal

PetCare+ aims to provide pet owners with a simple and reliable way to organize their pets' health information while reducing the risk of missed vaccinations, medications, and veterinary appointments.

The combination of Flutter, Firebase, Riverpod, Clean Architecture, and RevenueCat enables rapid development and a scalable foundation for the Shipaton 2026 project.

## 📄 Project Specification

This README is based on the project's Software Requirements Specification (SRS), which defines PetCare+ as a Flutter mobile application backed by Firebase and monetized through RevenueCat. fileciteturn0file0L5-L23
