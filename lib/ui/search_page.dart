import 'package:bfaf_submisi_restaurant_app/navigation.dart';
import 'package:bfaf_submisi_restaurant_app/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bfaf_submisi_restaurant_app/provider/restaurant_provider.dart';
import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_list.dart';
import 'package:bfaf_submisi_restaurant_app/styles.dart';
import 'package:bfaf_submisi_restaurant_app/ui/restaurant_detail.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search restaurant...',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          onChanged: (value) {
            // Call the fetch method whenever the text changes
            Provider.of<RestaurantProvider>(context, listen: false).fetchSearchRestaurant(value);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: _buildSearchResult(context),
    );
  }

  Widget _buildSearchResult(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (_searchController.text.isEmpty) {
          return const Center(
            child: Text('Search for a restaurant'),
          );
        } else {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          } else if (state.state == ResultState.hasData) {
            final searchResult = state.searchResult!.restaurants;
            return ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return _buildSearchItem(context, searchResult[index]);
              },
            );
          } else {
            return const Center(
              child: Text('No restaurants found'),
            );
          }
        }
      },
    );
  }

  Widget _buildSearchItem(BuildContext context, RestaurantListSummary restaurant) {
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
                    Navigation.intentWithData(RestaurantDetailPage.routeName, restaurant.id);
                  },
                ),
              ),
            );
          }
        );
      }
    );
  }
}
