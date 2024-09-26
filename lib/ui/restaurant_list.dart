import 'package:bfaf_submisi_restaurant_app/data/model/restaurant.dart';
import 'package:bfaf_submisi_restaurant_app/ui/detail_page.dart';
import 'package:flutter/material.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSliverList(context);
  }

  FutureBuilder<String> _buildSliverList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            final List<RestaurantElement> restaurants = restaurantFromJson(snapshot.data!).restaurants;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 100.0,
                  flexibleSpace:  FlexibleSpaceBar(
                    title: Text("Restaurants", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                    titlePadding: const EdgeInsets.all(16.0),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildRestaurantItem(context, restaurants[index]);
                    },
                    childCount: restaurants.length,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantElement restaurant) {
    return Card(
      borderOnForeground: true,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Hero(
          tag: restaurant.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              restaurant.pictureId,
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Icon(Icons.location_on, color: Theme.of(context).colorScheme.secondary, size: 14),
            Text(
              restaurant.city,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            RestaurantDetailPage.routeName,
            arguments: restaurant,
          );
        },
      ),
    );
  }
}