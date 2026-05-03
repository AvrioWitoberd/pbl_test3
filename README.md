# My Kos - Kos Finder App

My Kos is a simple yet scalable Flutter application aimed to help users find their desired boarding houses (KOS). This project follows a clean architecture approach, making it easy to maintain and extend with new features.

## Architecture & Folder Structure

- `lib/data/` Contains `dummy_data.dart` acting as our pseudo-database.
- `lib/models/` Contains `kos.dart` and `blog.dart` modeling the application's domain objects.
- `lib/providers/` Global State holders (`auth_provider.dart`, `kos_provider.dart`, `blog_provider.dart`).
- `lib/views/` Segregated views: `auth/`, `profile/`, `home/`, `blog/`, `favorite/`, ensuring high cohesion.
- `lib/widgets/` Reusable component code (e.g., `kos_card.dart`).

## Authentication Flow (User Only)

The application uses a simulated authentication flow with state management provided by the `provider` package.

1. **Role Selection Screen**: Users choose between "Pencari Kos" (navigates to Login) or "Pemilik Kos" (opens a dummy external link).
2. **Login Screen**: Simple form for email and password. If credentials match the dummy data, the user is logged in.
3. **Register Screen**: Simple form for user registration. Submitting the form simulates a successful registration and returns the user to the Login Screen.
4. **Logout Flow**: Accessed via the Profile Screen, a confirmation dialog appears before clearing the navigation stack and returning the user to the Role Selection Screen.

### Dummy Credentials
You can log in to the app using the following dummy credentials:
- **Email**: `user@gmail.com`
- **Password**: `123456`

## Navigation Flow

- **Before Login**: If `isLoggedIn == false`, the root widget is `RoleSelectionScreen`. The user is confined to the authentication flow (`RoleSelectionScreen`, `LoginScreen`, `RegisterScreen`).
- **After Login**: If `isLoggedIn == true`, the root widget transitions to `MainNavigationScreen`, which contains the `BottomNavigationBar` allowing access to Home, Blog, Favorite, and Profile. The app uses `pushAndRemoveUntil` to prevent back navigation to auth screens.

## Packages Used

- `provider`: For simple and clean state management (e.g., `AuthProvider`, `KosProvider`, `BlogProvider`).
- `url_launcher`: For opening external links like the "Pemilik Kos" portal and WhatsApp integration.
- `google_fonts`: For consistent typography (Inter font).

## Future Improvements

- **API Integration**: Replace dummy data and in-memory state with real backend API calls.
- **Real Authentication**: Implement Firebase Auth or an OAuth provider instead of dummy credentials.

## Getting Started

1. Ensure you have Flutter installed and configured.
2. Run `flutter pub get` to download dependencies.
3. Use `flutter run` on an emulator or real device.
