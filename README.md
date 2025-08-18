# Holo Challenge - Flutter E-commerce App

A Flutter e-commerce application built as part of the Holo technical assessment. This app demonstrates clean architecture, state management, and API integration to create a seamless shopping experience.

## 🚀 Features

### Core Features
- **Products Screen**: Browse through a list of products with image, title, price, category, loading states
- **Product Details**: View detailed information about individual products with Add to cart
- **Cart**: View products, update quantity, remove product, clear cart, summary
- **Responsive Design**: Support both iOS and Android

### Design Choices
- **Clean Architecture**: Following BLoC pattern using get_it with stream-based state management
- **State Management**: Custom BLoC implementation using RxDart streams
- **Local Storage**: Cart persistence using SharedPreferences
- **Network Layer**: REST API integration using http package with proper error handling for fakestoreapi structure

## 🏗️ Architecture

The app follows **BLoC (Business Logic Component) architecture** with stream-based state management:

```
lib/
├── core/
│   ├── api_service/       # Api service request
│   ├── app_router/        # Navigation service and routes
│   ├── di/                # Dependency injection setup
│   ├── constants/         # Constants for SharedPreferences keys, api endpoints, and app constants such as appName etc
│   ├── theme/             # App theming and responsive design
│   └── localization/      # English and Arabic support
├── modules/
│   ├── base/              # Base BLoC, state classes, custom popscope
│   ├── products/          # Product listing and details
│   ├── cart/              # Shopping cart functionality
│   └── settings/          # App settings
│   └── user_preferences/  # User preferences such as theme, language and currency
├── network/
│   ├── product/           # Product API models and repository
│   └── base/              # Network base classes
├── widgets/               # Reusable UI components
├── utils/                 # Reusable utilies such as logger, currency formats, network check, shared preferences, validation etc
└── main.dart
```

## 🌐 API Integration

### FakeStore API
This application integrates with the FakeStore API (https://fakestoreapi.com) with the following endpoints:

- **GET /products** - Fetch all products
- **GET /products/{id}** - Fetch product by ID

### API Limitations & Workarounds
**Note**: Due to limitations with the FakeStore API, only the products endpoints were reliable for this implementation:
- **Products API**: Successfully implemented products list and fetch product by id
- **Users API**: Data inconsistency prevented proper login/signup implementation
- **Cart API**: Server-side cart functionality was unreliable

**Solution**: Implemented local cart management using SharedPreferences to ensure cart persistence across app sessions.


### ✅ Completed Requirements
- [x] Product listing with API integration (image, title, price, category, loading states)
- [x] Product detail view (image, title, price, category, Add to cart)
- [x] Shopping cart View products, update quantity, remove product, clear cart, summary
- [x] Cart persistence using shared preferences
- [x] Responsive UI design
- [x] Error handling, empty states and loading states
- [x] Support iOS and Android
- [x] Theme switcher
- [x] Language switcher

### ⚠️ Known Limitations
- **Authentication**: Login/Signup not implemented due to FakeStore API user data inconsistencies
- **Server-side Cart**: Using local cart persistence instead of API-based cart due to API limitations

### Dev notes

- To Update splash screen run
  dart run flutter_native_splash:create

  in case if you are not able to find a path
  flutter pub run flutter_native_splash:create --path=/Users/taimoorsarwar/StudioProjects/holo_challenge/pubspec.yaml

- Localization
  If want to clear all localization generated files
  rm lib/core/localization/l10n/intl_messages.arb
  rm lib/core/localization/l10n/messages_*

  generate new files
  flutter pub run intl_translation:extract_to_arb --output-dir=lib/core/localization/l10n lib/core/localization/app_localization.dart                                
  flutter pub run intl_translation:generate_from_arb --output-dir=lib/core/localization/l10n --no-use-deferred-loading lib/core/localization/app_localization.dart lib/core/localization/l10n/intl_*.arb
