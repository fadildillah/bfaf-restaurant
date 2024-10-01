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
    return ListTile(
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: restaurant.id);
      },
    );
  }
}
