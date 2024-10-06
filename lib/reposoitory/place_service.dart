import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:shop_loc/model/place_model.dart';
import 'package:shop_loc/services/db_helper.dart';

class PlaceService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final String apiKey = 'AIzaSyCTFGHRay-B4bHUTZXG-vFIcOhAn4_mLO4'; // Replace with your API key

  Future<List<Place>> fetchNearbyPlaces(String location, String radius) async {
    // Fetch data from API
    Uri url = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/nearbysearch/json",
      {
        "location": location,
        "radius": radius,
        "type": "store",
        "key": apiKey,
      },
    );

    try {
      final response = await http.get(url);
      log(response.body);
      if (response.statusCode == 200) {
        List<dynamic> results = jsonDecode(response.body)['results'];

        // Get current location using Geolocator package
        Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        // Map each result to a Place object, passing the current location to calculate distance
        List<Place> places = results.map((json) => Place.fromJson(json, currentPosition)).toList();

        // Save the places to the database
        for (Place place in places) {
          await _databaseHelper.insertPlace(place);
        }

        return places;
      } else {
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      // If an error occurs, attempt to fetch places from local database
      log('Error occurred: $e');
      return await fetchPlacesFromDatabase();
    }
  }

  Future<List<Place>> fetchPlacesFromDatabase() async {
    return await _databaseHelper.getPlaces();
  }
}
