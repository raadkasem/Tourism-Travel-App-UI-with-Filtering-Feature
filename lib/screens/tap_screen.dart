import 'package:flutter/material.dart';
import 'package:travel_app/models/trip.dart';
import 'package:travel_app/screens/categories_screen.dart';
import '../widgets/app_drawer.dart';
import 'favoritesscreen.dart';

class TabsScreen extends StatefulWidget {
  final List<Trip> favoriteTrip;
  TabsScreen(this.favoriteTrip);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Widget>> _screens;

  @override
  void initState() {
    // Vid 22 ,
    _screens = [
      // نختار قيمة أوبجكت لما بدنا نختار أي نوع قيمة نريدها بدون تخديد
      {
        'Screen': CategoriesScreen(), 
        'Title': Text('التصنيفات')
      },
      {
        'Screen': FavoritesScreen(widget.favoriteTrip),
        'Title': Text('الرحلات المفضلة')
      }, 
    ];
    super.initState();
  }

  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: _screens[_selectedScreenIndex]['Title'],
        ),
        body: _screens[_selectedScreenIndex]['Screen'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedScreenIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'التصنيفات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'المفضلة',
            ),
          ],
        ));
  }
}
