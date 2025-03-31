# Car On Sale Assignment

## Overview
This repository contains the Car On Sale Assignment, a Flutter-based application designed to demonstrate key functionalities such as state management, API integration, and theme toggling. The app is built with clean architecture principles and leverages modern development practices.

## Features
- Light and Dark Theme Toggle
- VIN (Vehicle Identification Number) Search 
- Local and Remote Data Handling 
- Error Handling for Network Requests 
- State Management using Bloc/Cubit 
- Responsive UI with Material Design

## Project Structure
The project follows a feature based clean architecture structure:
```
lib/
├── core/               # Common utilities, constants, exceptions, themes, etc.
    ├── feature         # Module containing features
        ├── feature_name/  # Feature-specific code eg Home, Login
            ├── data/       # Data layer
                ├── models/  # Data models
                ├── repositories/  # Repositories for data access
                ├── datasources/  # Local and remote data sources
            ├── domain/      # Domain layer
                ├── entities/  # Domain entities
                ├── usecases/  # Use cases for business logic
            ├── presentation/ # Presentation layer
                ├── blocs/     # BLoC classes for state management
                ├── screens/   # UI screens
                ├── widgets/   # Reusable widgets
```

## Getting Started
### Prerequisites
Flutter SDK (>= 3.6.1)

### Installation
1. Clone the repository:
    ```
   git clone https://github.com/rohankandwal/car_on_sale_assignment.git 
   cd car_on_sale_assignment```

2. Install dependencies:
    ```
    flutter pub get
    ```
3. [Optional] Run pre-commit hooks:
   ```
   Open tool/setup_git_hooks.sh and run it
   ```
4. Run build_runner:
   ```
    dart run build_runner build --delete-conflicting-outputs 
    ```
5. Run the app by opening main_dev.dart or main_prod.dart

### Working
- **User Authentication**: User can login using email and password. However, we are using a random
bool to simulate success/failure of authentication. So, please try a couple of times to get a successful login.
Sample credentials - r@r.com/123123123 (min 6 characters)
- **VIN/Vehicle Search**: User can search for vehicles using a VIN. Based on the VIN, the user may 
get a full match or a list of similar vehicles. However, we are using https://pub.dev/packages/is_valid 
for VIN validation. Use 1G1AZ123456789012 as a test VIN.
- **Caching Data**: VIN search results are cached for 1 minute. If local copy exists, it will be used.