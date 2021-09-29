import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_app/app_data.dart';
import 'package:travel_app/screens/category_trips_screen.dart';
import './screens/filter_screen.dart';
import './screens/tap_screen.dart';
import 'screens/trip_detail_screen.dart';
import './models/trip.dart';
import './app_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool?> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrip = Trips_data;
  List<Trip> _favoriteTrip = [];

  void _changeFilters(Map<String, bool?> filterData) {
    setState(() {
      _filters = filterData;
      _availableTrip = Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavorite(String tripId) {  
    final existingIndex = _favoriteTrip.indexWhere((trip) =>
        trip.id ==
        tripId);  
    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrip.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteTrip.add(
          Trips_data.firstWhere((trip) => trip.id == tripId),
        );
      });
    }
  }

  bool _isFavorite(String id){
    return _favoriteTrip.any((trip) => trip.id == id );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', 'AE'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Travel APP',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'ElMessiri',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold))
          // textTheme:
          ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        // '/' : (ctx) => CategoriesScreen() ,
        '/': (ctx) => TabsScreen(_favoriteTrip),
        CategoryTripsScreen.RouteScreen: (ctx) =>
            CategoryTripsScreen(_availableTrip),
        TripDetailScreen.screenRoute: (ctx) => TripDetailScreen(_manageFavorite, _isFavorite),
        FilterScreen.screenRoute: (ctx) =>
            FilterScreen(_filters, _changeFilters),
      },
    );
  }
}
