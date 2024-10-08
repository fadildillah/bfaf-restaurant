import 'package:bfaf_submisi_restaurant_app/provider/scheduling_provider.dart';
import 'package:bfaf_submisi_restaurant_app/ui/favorites_page.dart';
import 'package:bfaf_submisi_restaurant_app/ui/restaurant_list.dart';
import 'package:bfaf_submisi_restaurant_app/ui/settings_page.dart';
import 'package:bfaf_submisi_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    const RestaurantList(),
    const FavoritesPage(),
    ChangeNotifierProvider(
      create: (_) => SchedulingProvider(),
      child: const SettingsPage(),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(FavoritesPage.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    selectNotificationSubject.close();
    super.dispose();
  }
}
