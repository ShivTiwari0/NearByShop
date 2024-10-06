import 'package:flutter/material.dart';
import 'package:shop_loc/model/place_model.dart';
import 'package:shop_loc/view/screens/place_details_screen.dart';

class PlaceTile extends StatelessWidget {
  final String name;
  final String vicinity;
  final double distance;
  final double rating;
  final int userRatingsTotal;
  final bool isOpen;
  final Place place;

  const PlaceTile({
    super.key,
    required this.name,
    required this.vicinity,
    required this.distance,
    required this.rating,
    required this.userRatingsTotal,
    required this.isOpen, required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Adds shadow for depth
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Icon(
            Icons.storefront,
            color: Colors.blueAccent,
            size: 40.0,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vicinity: $vicinity',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Distance: ${(distance / 1000).toStringAsFixed(2)} km',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(
                    '$rating ($userRatingsTotal reviews)',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                'Open Now: ${isOpen ? "Yes" : "No"}',
                style: TextStyle(
                  color: isOpen ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.blueGrey,
        ),
        onTap: () {
         
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlaceDetailsScreen(place: place),
    ),
  );
},

        
      ),
    );
  }
}
