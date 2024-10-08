import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_detail.dart';
import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_list.dart';
import 'package:bfaf_submisi_restaurant_app/provider/database_provider.dart';
import 'package:bfaf_submisi_restaurant_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RestaurantDetailWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  final bool isExpanded;
  final Function toggleExpand;

  const RestaurantDetailWidget({super.key, required this.restaurant, required this.isExpanded, required this.toggleExpand});

  @override
  State<RestaurantDetailWidget> createState() => _RestaurantDetailWidgetState();
}

class _RestaurantDetailWidgetState extends State<RestaurantDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final String pictureId = widget.restaurant.restaurant.pictureId;
    final restaurantData = widget.restaurant.restaurant;
    var dataToSaved = RestaurantListSummary(
      id: restaurantData.id,
      name: restaurantData.name,
      description: restaurantData.description,
      pictureId: restaurantData.pictureId,
      city: restaurantData.city,
      rating: restaurantData.rating,
    );
    final String imageUrl =
        'https://restaurant-api.dicoding.dev/images/large/$pictureId';
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(widget.restaurant.restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: isFavorite
                            ? IconButton(
                                onPressed: () => provider.removeFavorite(widget.restaurant.restaurant.id),
                                icon: Icon(Icons.favorite, color: Theme.of(context).colorScheme.secondary),
                              )
                            : IconButton(
                                onPressed: () => provider.addFavorite(dataToSaved),
                                icon: Icon(Icons.favorite_border, color: Theme.of(context).colorScheme.secondary),
                              ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                widget.restaurant.restaurant.name,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).colorScheme.secondary,
                                      size: 16,
                                    ),
                                    Text(
                                      widget.restaurant.restaurant.rating.toString(),
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: secondaryColor),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            Text(
                              widget.restaurant.restaurant.city,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.restaurant.restaurant.description,
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: widget.isExpanded ? null : 5,
                          overflow: widget.isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                        GestureDetector(
                          onTap: () => widget.toggleExpand(),
                          child: Text(
                            widget.isExpanded ? 'Show less' : 'Show more',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        widget.restaurant.restaurant.menus.foods.isNotEmpty
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
                                        for (var food in widget.restaurant.restaurant.menus.foods)
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
                        widget.restaurant.restaurant.menus.drinks.isNotEmpty
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
                                        for (var drink in widget.restaurant.restaurant.menus.drinks)
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
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.restaurant.restaurant.customerReviews.length,
                                itemBuilder: (context, index) {
                                  final review = widget.restaurant.restaurant.customerReviews[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Container(
                                      width: 200,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.name,
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.secondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            review.review,
                                            style: Theme.of(context).textTheme.labelMedium,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Icon(Icons.date_range, color: Theme.of(context).colorScheme.secondary, size: 14),
                                              Text(
                                                review.date,
                                                style: TextStyle(
                                                  color: Theme.of(context).colorScheme.onPrimary,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            widget.restaurant.restaurant.categories.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'Categories',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 32,
                                    child: Wrap(
                                      spacing: 8,
                                      children: [
                                        for (var category in widget.restaurant.restaurant.categories)
                                          Chip(
                                            label: Text(
                                              category.name,
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.secondary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            backgroundColor: Theme.of(context).colorScheme.primary,
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                              :
                              const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}


