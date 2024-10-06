import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_loc/model/place_model.dart';
import 'package:shop_loc/view/screens/map_screen.dart';


class PlaceDetailsScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image at the top
            if (place.imageUrl.isNotEmpty)
              Center(
                child:CachedNetworkImage(imageUrl: place.imageUrl ,
                 
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 100,
                ),
              ),
            const SizedBox(height: 16.0),

            // Place description
            Text(
              place.description,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Vicinity information
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Vicinity: ${place.vicinity}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Distance information
            Row(
              children: [
                const Icon(Icons.directions_walk),
                const SizedBox(width: 8.0),
                Text(
                  'Distance: ${(place.distance / 1000).toStringAsFixed(2)} km away',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Rating and user ratings
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 8.0),
                Text(
                  'Rating: ${place.rating} (${place.userRatingsTotal} reviews)',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Open Now status
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8.0),
                Text(
                  'Open Now: ${place.isOpen ? "Yes" : "No"}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: place.isOpen ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),  

            // Add a button to navigate back or perform any other action
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(latitude: place.lat, longitude: place.lng, name: place.name),));
                },
                child: const Text('Show on Map'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
