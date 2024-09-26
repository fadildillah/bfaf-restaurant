import 'package:bfaf_submisi_restaurant_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final RestaurantElement restaurant;

  const RestaurantDetailPage ({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurant.name,
          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontFamily: "Dortmund"),
        ),
        bottomOpacity: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.restaurant.pictureId,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurant.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.overline,
                          decorationColor: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
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
                              widget.restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Text(
                        widget.restaurant.city,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.restaurant.description,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: _isExpanded ? null : 5,
                    overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? 'Show less' : 'Show more',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  widget.restaurant.menus.foods.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Foods',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 32,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var food in widget.restaurant.menus.foods)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Chip(
                                        label: Text(
                                          food.name,
                                          style: Theme.of(context).textTheme.labelSmall,
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                          color: Theme.of(context).colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 16),
                  widget.restaurant.menus.drinks.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Drinks',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 32,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var drink in widget.restaurant.menus.drinks)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Chip(
                                        label: Text(
                                          drink.name,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            // using textTheme.labelSmall will make the text color white
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                          color: Theme.of(context).colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),    
    );
  }
}