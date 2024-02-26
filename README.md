# Flutter Flash News
 "FlashNews: A sleek and efficient Flutter app that delivers the latest news at your fingertips. Powered by NewsAPI.org, it ensures you're always updated with the world's happenings, anytime, anywhere. Dive into a world of information with FlashNews."

 ## Requirements

- Flutter 3+
- Xcode 14.x / 15.x (for iOS/macOS)
- Android Studio 4+ (for Android)

## Configure Flash News Application

### 📱 Env file
Flash News app uses [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) for its configuration.

Go to main page of [newsapi.org](https://newsapi.org/)
1. Click on 'Get API Key' and follow instructions to get the API Key
1. Rename `.env.example` to `.env` and provide the appropriate **Key**
2. Update variable with your key.

```sh
NEWS_API_KEY = 00000
```

## Run the Flash News Application

Make sure you already set your environmet variables in the the `env.` file.

Update the packages of your `pubspec.yaml`, use the [Flutter CLI's](https://docs.flutter.dev/reference/flutter-cli) `flutter pub get` command.

Ensure you have at least one emulator running. If you have multiple running, the CLI will prompt you to select the one to run the app on.

To run the project, use the [Flutter CLI's](https://docs.flutter.dev/reference/flutter-cli) `run` command.

### 📱 Mobile/Desktop

```sh
flutter run
```

## Compile the Flash News Application

To compile the project, use the [Flutter CLI's](https://docs.flutter.dev/reference/flutter-cli) `build` command, including the platform you want to target.

```sh
flutter build apk
flutter build ios
flutter build macos
flutter build web
```


## Isar DB

If you want to create a new local table using Isar:
1. Add the `part 'name_of_your_entity.g.dart'` 
2. Decorate your entity with `@collection`
3. Add `Id? isarId;` field in your Entity Class
3. Run the `dart run build_runner build` command.

/*
 * How to Run Tests in This App
 * -----------------------------
 * 
 * Step 1: Generate Mocks and Other Required Files
 * ------------------------------------------------
 * Run the following commands in your terminal to generate mock classes and any other required files using build_runner:
 * 
 * flutter pub get
 * flutter pub run build_runner build --delete-conflicting-outputs
 * 
 * Step 2: Running Tests
 * ----------------------
 * To run all tests in the project, execute:
 * 
 * flutter test
 * 
 * To run a specific test file, use:
 * 
 * flutter test test/path_to_your_test_file.dart
 * 
 * Make sure to regenerate files with build_runner if you have made changes to files that affect code generation.
 */