import 'dart:io';

import 'package:bfaf_submisi_restaurant_app/provider/scheduling_provider.dart';
import 'package:bfaf_submisi_restaurant_app/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 100.0,
          flexibleSpace:  FlexibleSpaceBar(
            title: Text("Settings", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
              return _buildSettingItem(context);
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Scheduling Restaurant Notification'),
        subtitle: const Text('Enable or disable restaurant notification'),
        trailing: Consumer<SchedulingProvider>(
          builder: (context, scheduled, _) {
            return Switch.adaptive(
              value: scheduled.isScheduled,
              onChanged: (value) async {
                if (Platform.isIOS) {
                  customDialog(context);
                } else {
                  scheduled.scheduledRestaurant(value);
                }
              },
            );
          },
        ),
      ),
    );
  }
}