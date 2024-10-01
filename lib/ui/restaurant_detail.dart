import 'package:bfaf_submisi_restaurant_app/provider/restaurant_provider.dart';
import 'package:bfaf_submisi_restaurant_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bfaf_submisi_restaurant_app/widgets/detail_widget.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  const RestaurantDetailPage ({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool _isExpanded = false;
  late String restaurantId;
  late Future<void> _restaurantDetailFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    _restaurantDetailFuture = Provider.of<RestaurantProvider>(context, listen: false)
        .fetchRestaurantDetail(restaurantId);
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: FutureBuilder(
        future: _restaurantDetailFuture, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final restaurantDetail = Provider.of<RestaurantProvider>(context).detailResult;
            return RestaurantDetailWidget(restaurant: restaurantDetail, isExpanded: _isExpanded, toggleExpand: _toggleExpand);
          }
        }
      )
    );
  }
}