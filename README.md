# Route Partners

## Overview

Welcome to the Route Patners Application! This repository contains the code written for the development of flutter mobile app. This README provides an overview of the project and specifies which parts of the codebase has been coded by me.

## Project Structure

The project is organized into the following main directories:

- `lib/` - Contains the Dart code for the application.
  - `lib/screens/` - Includes all the screen files for the application.
  - `lib/services/` - Includes services such as API calls, authentication, and data handling.
  - `lib/enums/` - Contains enum definitions, including permissions and network status.
  - `lib/model/` - Contains data models used in the application.
- `assets/` - Includes images, fonts, and other static resources.

## My Contributions

Here’s a breakdown of the code and features I have implemented in this project:

### 1. **Feature Implementation**

- **Home Screen**: Designed and developed the home screen UI, including the layout and interactive elements.
  - **File**: `lib/screens/dashboard.dart`
  
- **User Authentication**: Implemented user sign-up and login functionality using Firebase Authentication.
  - **Files**: 
    - `lib/controllers/auth_controller.dart`
    - `lib/screens/authentication_screena.dart`
  
- **API Integration**: Integrated with the REST API to fetch and display data.
  - **Files**: 
    - `lib/services/api.dart`

### 2. **UI/UX Design**
    
- **Theme and Styles**: Defined the app's theme, including colors, images and text styles etc.
  - **File**: 
    - `lib/core/constants/app_colors.dart`
    - `lib/core/constants/app_fonts.dart`
    - `lib/core/constants/app_images.dart`
    - `lib/core/constants/app_sizes.dart`
    - `lib/core/constants/app_styling.dart`

### 3. **App Permissions**

Implemented and managed the app's permissions to ensure proper functionality and user experience.

- **Bluetooth Permission**: Managed Bluetooth permission requests and handling.
  - **File**: `lib/enums/bluetooth_permission.dart`
  
- **Location Permission**: Managed location permission requests and handling.
  - **File**: `lib/enums/location_permission.dart`
  
- **Message Permissions**: Managed permissions related to messaging services within the app.
  - **File**: `lib/enums/message_enum.dart`
  
- **Network Status**: Handled permissions and checks related to the app's network status.
  - **File**: `lib/enums/network_status.dart`


## Getting Started

To get started with the project, follow these steps:

1. **Clone the Repository**

    ```bash
    git clone https://github.com/jawadnasar/routes_partners.git
    ```

2. **Navigate to the Project Directory**

    ```bash
    cd routes_partners
    ```

3. **Install Dependencies**

    ```bash
    flutter pub get
    ```

4. **Run the Application**

    ```bash
    flutter run
    ```

## Contact

For any questions or feedback, you can reach me at:

- **Email**: jawadnasar7886@gmail.com
- **GitHub**: [jawadnasar](https://github.com/jawadnasar)
