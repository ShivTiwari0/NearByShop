
import 'package:flutter/material.dart';
import 'package:shop_loc/model/place_model.dart';
import 'package:shop_loc/reposoitory/place_service.dart';


class PlaceViewModel extends ChangeNotifier {
  List<Place> _places = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Place> get places => _places;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final PlaceService _placeService = PlaceService();

  void fetchNearbyPlaces(String location, String radius) async {
    _isLoading = true;
    notifyListeners();

    try {
      _places = await _placeService.fetchNearbyPlaces(location, radius);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
