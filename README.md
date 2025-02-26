# E-Commerce App

Welcome to the **E-Commerce App** Flutter project. This project serves as a scalable and maintainable template for building a fully-functional e-commerce mobile application. The app is developed using **Flutter** and follows **Clean Architecture** principles to ensure proper separation of concerns, ease of testing, and scalability.

## Features

This template covers essential e-commerce functionalities, including:

- **Authentication** (Login/Signup)
- **Product Listing & Details**
- **Cart Management**
- **Order Placement & Tracking**
- **Wishlist Functionality**
- **User Profile Management**
- **Dark Mode Support**

## Getting Started

### Prerequisites

Before setting up the project, ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart](https://dart.dev/get-dart)
- An IDE such as **Visual Studio Code** or **Android Studio**
- A device/emulator for testing

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/a7medjamal/e-commerce_app
   cd e-commerce_app
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Run the application:
   ```sh
   flutter run
   ```

## Project Structure

The project follows the **Clean Architecture** pattern, dividing code into distinct layers:

```
lib/
|-- core/         # Shared utilities, themes, constants
|   |-- error/    # Error handling classes
|   |-- network/  # API and network-related utilities
|   |-- usecases/ # Business logic use cases
|   |-- utils/    # Helper functions and utilities
|   |-- widgets/  # Shared UI components
|   |-- AppRoutes.dart # Navigation routes configuration
|
|-- features/     # Feature-based modules
|   |-- auth/     # Authentication feature
|   |   |-- data/         # Data layer (API, local storage)
|   |   |-- domain/       # Business logic and use cases
|   |   |-- presentation/  # UI and state management
|   |   |-- widgets/      # UI components related to authentication
|   |   |-- injection_container.dart # Dependency injection
|   |
|   |-- cart/     # Cart management feature
|   |   |-- data/
|   |   |-- domain/
|   |   |-- presentation/
|   |   |-- injection_container.dart
|   |
|   |-- home/     # Home screen feature
|   |   |-- widgets/
|   |   |-- home_screen.dart
|   |
|   |-- order/    # Order placement and tracking feature
|   |   |-- data/
|   |   |-- domain/
|   |   |-- presentation/
|   |   |-- injection_container.dart
|   |
|   |-- product/  # Product listing and details feature
|   |   |-- data/
|   |   |-- domain/
|   |   |-- presentation/
|   |   |-- injection_container.dart
|
|-- firebase_options.dart  # Firebase configuration
|-- injection_container.dart # Global dependency injection setup
|-- main.dart  # Application entry point
```

### Explanation

- **Core Layer**: Contains shared utilities, error handling, network configurations, and reusable widgets.
- **Features**: Each feature is modularized with its **data**, **domain**, and **presentation** layers following the Clean Architecture approach.
- **Injection Container**: Used for dependency injection to keep the project scalable and maintainable.
- **Main.dart**: The entry point of the Flutter application.
- **Firebase Options**: Handles Firebase-related configurations if Firebase is used.

## Tech Stack

- **Flutter**: UI Development
- **Dart**: Programming Language
- **Bloc**: State Management
- **Firebase**: Authentication & Backend (Optional)
- **Hive / SharedPreferences**: Local Storage

## Contribution Guidelines

If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`feature/your-feature-name`).
3. Commit your changes with clear messages.
4. Push to the branch and create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

Happy coding! 🚀
