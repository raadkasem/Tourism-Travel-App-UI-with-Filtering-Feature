import 'package:flutter/material.dart';
import 'package:travel_app/models/trip.dart';
import '../screens/trip_detail_screen.dart';

class TripItem extends StatelessWidget {
  const TripItem(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.duration,
      required this.tripType,
      required this.season,
      required this.id,
      // required this.removeItem
       })
      : super(key: key);

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final TripType tripType;
  final Season season;
  // final Function removeItem;

  String get seasonText {
    switch (season) {
      case Season.Winter:
        return 'شتاء';

      case Season.Spring:
        return 'ربيع';

      case Season.Summer:
        return 'صيف';

      case Season.Autumn:
        return 'خريف';

      default:
        return 'غير معروف';
    }
  }

  String get tripsType {
    switch (tripType) {
      case TripType.Exploration:
        return 'استكشاف';
      case TripType.Recovery:
        return 'نقاهة';
      case TripType.Activities:
        return 'نشاطات';
      case TripType.Therapy:
        return 'علاج';
      default:
        return 'غير معروف';
    }
  }

  void selectTrip(BuildContext context) {
    Navigator.of(context)
        .pushNamed(TripDetailScreen.screenRoute, arguments: id)
        .then((result) {
            if(result != null){
              // removeItem(result);
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTrip(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 250,
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.8)
                      ],
                          stops: [
                        0.7,
                        1
                      ])),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.fade,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$duration يوم'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$seasonText'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(tripsType),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}