import 'package:flutter/material.dart';
import '../widgets/trip_item.dart';
import '../models/trip.dart';

class FavoritesScreen extends StatelessWidget {
  // const FavoritesScreen({ Key? key }) : super(key: key);

  final List<Trip> favoriteTrip;

  FavoritesScreen(this.favoriteTrip);

  @override
  Widget build(BuildContext context) {
    if (favoriteTrip.isEmpty) {
      return Center(
        child: Text('لا يوجد لديك أي رحلة مفضلة'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
              id: favoriteTrip[index].id,
              title: favoriteTrip[index].title,
              imageUrl: favoriteTrip[index].imageUrl,
              duration: favoriteTrip[index].duration,
              tripType: favoriteTrip[index].tripType,
              season: favoriteTrip[index].season,
              // removeItem: _removeTrip
               );
        },
        itemCount: favoriteTrip.length,
      );
      
    }
  }
}
