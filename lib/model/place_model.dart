import 'package:geolocator/geolocator.dart';

class Place {
  final int? id; // Optional id for SQLite
  final String name;
  final String vicinity;
  final double lat;
  final double lng;
  final double distance; // Distance from current location
  final double rating; // Average rating
  final int userRatingsTotal; // Number of user ratings
  final bool isOpen; // Whether the place is open now
  final String imageUrl; // Image URL for the place
  final String description; // Short description

  Place({
    this.id,
    required this.name,
    required this.vicinity,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.rating,
    required this.userRatingsTotal,
    required this.isOpen,
    required this.imageUrl,
    required this.description,
  });

  // Convert Place to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'vicinity': vicinity,
      'lat': lat,
      'lng': lng,
      'distance': distance,
      'rating': rating,
      'userRatingsTotal': userRatingsTotal,
      'isOpen': isOpen ? 1 : 0, // Store as integer (1 for true, 0 for false)
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  // Factory method to create Place from Map
  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      name: map['name'],
      vicinity: map['vicinity'],
      lat: map['lat'],
      lng: map['lng'],
      distance: map['distance'],
      rating: map['rating'],
      userRatingsTotal: map['userRatingsTotal'],
      isOpen: map['isOpen'] == 1,
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }

  // Factory method to create Place from JSON response
  factory Place.fromJson(Map<String, dynamic> json, Position currentLocation) {
    double placeLat = json['geometry']['location']['lat'];
    double placeLng = json['geometry']['location']['lng'];

    // Calculate distance from the current location using the Haversine formula
    double distance = Geolocator.distanceBetween(
      currentLocation.latitude, 
      currentLocation.longitude, 
      placeLat, 
      placeLng
    );

    // Fetch image from photos array if available
    String imageUrl = '';
    if (json['photos'] != null && json['photos'].isNotEmpty) {
      String photoReference = json['photos'][0]['photo_reference'];
      imageUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=AIzaSyCTFGHRay-B4bHUTZXG-vFIcOhAn4_mLO4'; // Replace with your API key
    }

    // Placeholder description (you could adjust this to include real data if available)
    String description = 'A great place to visit in the area.';

    return Place(
      name: json['name'],
      vicinity: json['vicinity'],
      lat: placeLat,
      lng: placeLng,
      distance: distance, // in meters
      rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
      userRatingsTotal: json['user_ratings_total'] != null ? json['user_ratings_total'] : 0,
      isOpen: json['opening_hours'] != null ? json['opening_hours']['open_now'] : false,
      imageUrl: imageUrl,
      description: description,
    );
  }
}
