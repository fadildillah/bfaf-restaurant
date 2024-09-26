import 'package:bfaf_submisi_restaurant_app/data/model/restaurant.dart';
import 'package:bfaf_submisi_restaurant_app/styles.dart';
import 'package:bfaf_submisi_restaurant_app/ui/detail_page.dart';
import 'package:bfaf_submisi_restaurant_app/ui/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          onPrimary: textPrimary,
          secondary: secondaryColor,
        ),
        textTheme: myTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: primaryColor,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as RestaurantElement,
        ),
      },
    );
  }
}
