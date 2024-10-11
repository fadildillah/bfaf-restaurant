# Simple Restaurant App

This Flutter app is my final submission for the **Belajar Fundamental Aplikasi Flutter** course in Dicoding Academy. The app allows users to browse a list of restaurants, view detailed information, add them to favorites, and schedule reminders using local notifications.

## Features

- **Restaurant List**: Browse through a list of restaurants.
- **Restaurant Details**: View detailed information about a restaurant by clicking on it.
- **Favorites**: Add restaurants to your favorites for easy access.
- **Local Notifications**: Schedule reminders for restaurants using local notifications.

## Topics Covered

This project covers various fundamental topics of Flutter development:

1. **State Management with Provider**: Used for managing the app's state efficiently.
2. **Fetching Data from the Internet**: The app uses the Dart `http` package to retrieve restaurant data from an API.
3. **Scheduling and Local Notifications**: Users can set reminders for restaurants with local notifications.
4. **Local Storage**: 
   - `SharedPreferences` is used for saving simple data like favorite restaurants.
   - `sqflite` is used for local database storage.
5. **Testing**: Unit and widget tests are included to ensure app functionality.
6. **Firebase**: Integrated for features such as backend services and potential app analytics.

## Project Structure

1. **Main Screen**: Displays a list of restaurants.
2. **Details Screen**: Displays detailed information about each restaurant.
3. **Favorites Screen**: Allows users to add and remove restaurants from their favorites.
4. **Notification Feature**: Users can schedule reminders for their favorite restaurants.

## Screenshots

<div style="display: flex; gap: 10px;">
  <img src="https://i.allthepics.net/2024/10/11/flutter_01.png" alt="Main Screen" width="200"/>
  <img src="https://i.allthepics.net/2024/10/11/flutter_03.jpeg" alt="Details Screen" width="200"/>
  <img src="https://i.allthepics.net/2024/10/11/flutter_02.md.png" alt="Favorites Screen" width="200"/>
  <img src="https://i.allthepics.net/2024/10/11/flutter_04.png" alt="Search Screen" width="200"/>
  <img src="https://i.allthepics.net/2024/10/11/flutter_05.png" alt="Notification Feature" width="200"/>
</div>

