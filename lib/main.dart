import 'package:bfaf_submisi_restaurant_app/data/api/api_service.dart';
import 'package:bfaf_submisi_restaurant_app/data/db/database_helper.dart';
import 'package:bfaf_submisi_restaurant_app/provider/database_provider.dart';
import 'package:bfaf_submisi_restaurant_app/provider/restaurant_provider.dart';
import 'package:bfaf_submisi_restaurant_app/styles.dart';
import 'package:bfaf_submisi_restaurant_app/ui/restaurant_detail.dart';
import 'package:bfaf_submisi_restaurant_app/ui/home_page.dart';
import 'package:bfaf_submisi_restaurant_app/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
      ],
      child: MaterialApp(
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
            RestaurantDetailPage.routeName: (context) => const RestaurantDetailPage(),
            SearchPage.routeName: (context) => const SearchPage(),
          },
      ),
    );
  }
}
