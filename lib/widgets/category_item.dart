import 'package:flutter/material.dart';
import '../screens/category_trips_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const CategoryItem({Key? key,required this.id, required this.title, required this.imageUrl})
      : super(key: key);

void selectCategory(BuildContext ctx){
  Navigator.of(ctx).pushNamed(
    CategoryTripsScreen.RouteScreen,
    arguments: <String, String>{
      'id':id,
      'title': title,
    },
  );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> selectCategory(context) , // anonymous function من أجل تمرير الكونتكسctx
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        ],
      ),
    );
  }
}
