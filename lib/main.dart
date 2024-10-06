import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_loc/view/screens/place_screen.dart';
import 'package:shop_loc/view_model.dart/place_view_model.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaceViewModel()), // Add your PlaceViewModel provider
        // You can add more providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(    debugShowCheckedModeBanner: false,
      title: 'Shop Locator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NearbyPlacesView(), // Your home screen
    );
  }
}
