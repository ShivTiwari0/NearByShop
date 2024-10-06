import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shop_loc/utils/utils.dart';
import 'package:shop_loc/view/widget/place_tile.dart';
import 'package:shop_loc/view_model.dart/place_view_model.dart';


class NearbyPlacesView extends StatefulWidget {
  const NearbyPlacesView({super.key});

  @override
  State<NearbyPlacesView> createState() => _NearbyPlacesViewState();
}

class _NearbyPlacesViewState extends State<NearbyPlacesView> {
  double? lat;
  double? long;
  final String radius = '1500';
  @override
  void initState() {
     getCurrentLocationAndFetchPlaces();
    super.initState();
    
  }

  // Method to fetch current location and use it to call fetchNearbyPlaces
  Future<void> getCurrentLocationAndFetchPlaces() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show a message to the user   
      Utils.snackBar('Location services are disabled.', context);
      return;
    }

    // Check and request permission if not granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show a message to the user
        Utils.snackBar('Location permissions are denied', context);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, show a message to the user
      Utils.snackBar(
          'Location permissions are permanently denied. Please enable it in settings.', context);
      return;
    }

    // If permissions are granted, fetch the current location
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    setState(() {
      lat = currentPosition.latitude;
      long = currentPosition.longitude;
    });

    // Fetch places using the fetched latitude and longitude
    String location = '$lat,$long';
    print(location);
    Provider.of<PlaceViewModel>(context, listen: false)
        .fetchNearbyPlaces(location, radius);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Shops'),
      ),
      body: Consumer<PlaceViewModel>(
        builder: (context, placeViewModel, child) {
          if (placeViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (placeViewModel.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${placeViewModel.errorMessage}'));
          } else {
            return ListView.builder(
              itemCount: placeViewModel.places.length,
              itemBuilder: (context, index) {
                var place = placeViewModel.places[index];
                return  PlaceTile(place: place,
                  name: place.name,
                  vicinity: place.vicinity,
                  distance: place.distance,
                  rating: place.rating,
                  userRatingsTotal: place.userRatingsTotal,
                  isOpen: place.isOpen,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fetch current location and get nearby places
          getCurrentLocationAndFetchPlaces();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
