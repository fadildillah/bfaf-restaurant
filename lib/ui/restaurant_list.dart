import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_list.dart';
import 'package:bfaf_submisi_restaurant_app/provider/database_provider.dart';
import 'package:bfaf_submisi_restaurant_app/provider/restaurant_provider.dart';
import 'package:bfaf_submisi_restaurant_app/styles.dart';
import 'package:bfaf_submisi_restaurant_app/ui/restaurant_detail.dart';
import 'package:bfaf_submisi_restaurant_app/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSliverList(context);
  }

  Widget _buildSliverList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: secondaryColor),
          );
        } else if (state.state == ResultState.hasData) {
          final List<RestaurantListSummary> restaurants = state.result.restaurants;
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
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SearchPage.routeName);
                    },
                  ),
                ],
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
        } else if (state.state == ResultState.noData) {
          return const Center(
            child: Text('No data'),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: secondaryColor),
          );
        }
      }
    );
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantListSummary restaurant) {
    final String? pictureId = restaurant.pictureId;
    final String imageUrl = 'https://restaurant-api.dicoding.dev/images/small/$pictureId';
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Material(
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  trailing: isFavorite
                        ? IconButton(
                          onPressed: () => provider.removeFavorite(restaurant.id),
                          icon: Icon(Icons.favorite, color: Theme.of(context).colorScheme.secondary),
                        )
                        : IconButton(
                          onPressed: () => provider.addFavorite(restaurant),
                          icon: Icon(Icons.favorite_border, color: Theme.of(context).colorScheme.secondary),
                        ),
                  leading: Hero(
                    tag: imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 100,
                      ),
                    ),
                  ),
                  title: Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.labelLarge,
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Theme.of(context).colorScheme.secondary, size: 14),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Row(
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
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: restaurant.id,
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );

  }
}