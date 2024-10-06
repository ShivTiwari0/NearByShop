# NearByShop

**NearByShop** is a Flutter application that allows users to find nearby stores and places of interest. The app uses the Google Places API and integrates SQLite for offline storage of place data.

![Screenshot1](assets/screenshot1.jpg)    ![Screenshot3](assets/screenshot3.jpg)
![Screenshot2](assets/screenshot2.jpg)


## Features

- **Google Places Integration**: Fetches nearby places based on the user's location and displays relevant details.
- **Offline Storage**: Stores place information using SQLite for offline access.
- **Distance Calculation**: Calculates the distance between the user's current location and nearby places.
- **Cached Images**: Efficiently loads and caches images from the Google Places API using `cached_network_image`.
- **Detailed Place Information**: Each place shows details like name, rating, user reviews, vicinity, and whether it is currently open.
  
## Technologies Used

- **Flutter**: For building the mobile app UI.
- **Google Places API**: For fetching nearby stores and points of interest.
- **SQLite**: For offline storage and retrieval of place data.
- **Geolocator**: For fetching user’s current location and calculating distance to nearby places.
- **Cached Network Image**: For efficient image loading and caching.
- **Provider**: For state management.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ShivTiwari0/NearByShop.git

2. Navigate to the project directory:
  cd NearByShop

3. Install dependencies:   
  flutter pub get



4. Add your Google Places API key in lib/services/place_service.dart:

5. Run the App 
  flutter run

**How It Works**
The app retrieves the user's location using the Geolocator package.
It then uses the Google Places API to fetch a list of nearby stores based on the user’s current location and a predefined radius.
Details like store name, vicinity, rating, number of user ratings, and open status are displayed.
If the device is offline, the app retrieves the previously saved places from SQLite storage.
Cached images ensure that places load quickly even with limited network connectivity.