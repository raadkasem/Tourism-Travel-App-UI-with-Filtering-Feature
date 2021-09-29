import 'package:flutter/material.dart';
import 'package:travel_app/models/trip.dart';
import 'package:travel_app/widgets/trip_item.dart';


class CategoryTripsScreen extends StatefulWidget {
//   const CategoryTripsScreen({Key? key,required this.categoryId, required this.categoryTitle}) : super(key: key);

// final String categoryId;
// final String categoryTitle;

  static const RouteScreen = '/category-trips';

  final List<Trip> availableTrip;

  CategoryTripsScreen(this.availableTrip);

    @override
  _CategoryTripsScreenState createState() => _CategoryTripsScreenState();
}

class _CategoryTripsScreenState extends State<CategoryTripsScreen> {

  String? categoryTitle;
  List<Trip>? displayTrips;

    @override
  void initState() {
    //......
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgument =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgument['id'];
    categoryTitle = routeArgument['title'];
    displayTrips =
        widget.availableTrip.where((trip) => trip.categories.contains(categoryId))
            .toList();
    super.didChangeDependencies();
  }

      void _removeTrip(String tripId){
        setState(() {
          displayTrips!.removeWhere((trip) => trip.id == tripId);
        });
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
              id: displayTrips![index].id,
              title: displayTrips![index].title,
              imageUrl: displayTrips![index].imageUrl,
              duration: displayTrips![index].duration,
              tripType: displayTrips![index].tripType,
              season: displayTrips![index].season,
              // removeItem: _removeTrip 
              );
        },
        itemCount: displayTrips!.length,
      ),
    );
  }
}
