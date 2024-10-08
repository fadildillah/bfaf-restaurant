import 'package:bfaf_submisi_restaurant_app/provider/database_provider.dart';
import 'package:bfaf_submisi_restaurant_app/provider/restaurant_provider.dart';
import 'package:bfaf_submisi_restaurant_app/ui/restaurant_detail.dart';
import 'package:bfaf_submisi_restaurant_app/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/favorites';
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          if (provider.favorites.isEmpty) {
            return const Center(
              child: Text('No favorites yet'),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 100.0,
                  flexibleSpace:  FlexibleSpaceBar(
                    title: Text("Favorites", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
                        color: Colors.white,
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
                      final favorite = provider.favorites[index];
                      final imgUrl = 'https://restaurant-api.dicoding.dev/images/small/${favorite.pictureId}';
                      return Card(
                        child: ListTile(
                          leading: Hero(
                            tag: imgUrl, 
                            child: Image.network(imgUrl, width: 100, fit: BoxFit.cover),
                          ),
                          title: Text(favorite.name, style: Theme.of(context).textTheme.bodyMedium),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Theme.of(context).colorScheme.secondary),
                                  Text(favorite.city, style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 16, color: Theme.of(context).colorScheme.secondary),
                                  Text(favorite.rating.toString(), style: Theme.of(context).textTheme.bodySmall),
                                ],
                              )
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              provider.removeFavorite(favorite.id);
                            },
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: favorite.id);
                          },
                        ),
                      );
                    },
                    childCount: provider.favorites.length,
                  ),
                )
              ],
            );
          }
        } else {
          return const Center(
            child: Text('Failed to load favorites'),
          );
        }
      }
    );
  }
}