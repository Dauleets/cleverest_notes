# Cleverest Notes

A Flutter project built using clean architecture and Reso Coder's tutorial.

## Introduction

This project is a Flutter application for creating and managing notes. It follows the clean architecture principles as taught in Reso Coder's tutorial. The application uses various packages for different functionalities, including local data storage with Drift, Flutter BLoC for state management, and other utility packages.

## Packages Used

The following packages are used in this project:

- cupertino_icons: ^1.0.2
- flutter_bloc: ^8.1.3
- equatable: ^2.0.5
- get_it: ^7.6.0
- dartz: ^0.10.1
- flutter_svg: ^2.0.7
- intl: ^0.18.1
- path_provider: ^2.0.0
- path: ^1.8.3
- hive: ^2.2.3
- hive_flutter: ^1.1.0
- sqflite: ^2.2.8+4
- flutter_reorderable_list: ^1.3.1
- go_router: ^8.1.0

## Getting Started

To get started with this Flutter project, follow these steps:

1. Install Flutter by following the instructions in the [Flutter documentation](https://flutter.dev/docs/get-started/install).
2. Clone this repository to your local machine.
3. Open the project in your preferred IDE or editor.
4. Run `flutter pub get` to install the project dependencies.
5. Connect a device or start an emulator.
6. Run `flutter run` to build and launch the application on your device or emulator.

For more information on Flutter development, you can refer to the [online documentation](https://docs.flutter.dev/), which provides tutorials, samples, and a full API reference.

## Architecture

This project follows the principles of clean architecture as taught by Reso Coder. It uses BLoC (Business Logic Component) for state management and separates the application into different layers:

- Presentation: Contains the UI code, including widgets, pages, and blocs.
- Domain: Defines the business logic and use cases of the application.
- Data: Implements the data sources, repositories, and models used by the application.

## File Structure

The main files and directories in this project are:

- `lib/`: Contains the main source code of the Flutter application.
  - `core/`: Contains core functionalities and utilities.
  - `features/`: Contains the features of the application.
    - `data/`: Implements the data layer of the application.
    - `domain/`: Defines the domain layer of the application.
    - `presentation/`: Contains the UI layer of the application.
  - `injection.dart`: Handles dependency injection using GetIt.
  - `main.dart`: The entry point of the application.

## Contributing

Contributions to this project are welcome. If you find any issues or want to add new features, feel free to open an issue or submit a pull request.
