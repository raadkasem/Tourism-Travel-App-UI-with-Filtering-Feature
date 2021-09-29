import 'package:flutter/material.dart';
import '../app_data.dart';

class TripDetailScreen extends StatelessWidget {
  final Function manageFavorite;
  final Function isFavorite;
  TripDetailScreen(this.manageFavorite, this.isFavorite);

  static const screenRoute = '/trip_detail';

  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedTrip = Trips_data.firstWhere((trip) => trip.id == tripId);

    return Scaffold(
        appBar: AppBar(title: Text('${selectedTrip.title}')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedTrip.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'الأنشطة'),
              buildListViewContainer(ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  elevation: 0.3,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedTrip.activities[index]),
                  ),
                ),
                itemCount: selectedTrip.activities.length,
              )),
              SizedBox(
                height: 10,
              ),
              buildSectionTitle(context, 'البرنامج اليومي'),
              buildListViewContainer(ListView.builder(
                itemCount: selectedTrip.program.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('يوم ${index + 1}'),
                      ),
                      title: Text(selectedTrip.program[index]),
                    ),
                    Divider()
                  ],
                ),
              )),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(
            isFavorite(tripId) ? Icons.star : Icons.star_border
            // نستدعي تابع التحقق من المفضلة ونمرر له رقم الرحلة 
            // هنا اذا كانت موجودة بالمفضلة فمعناها اظهر نجمة معباية
            //اذا لم تكن من المفضلة فأظهر نجمة فارغة
            ),
          tooltip: isFavorite(tripId) ? 'حذف المفضلة': 'أضف من المفضلة' ,
          onPressed:() => manageFavorite(tripId)
        ,
        ),
        );
  }
}
