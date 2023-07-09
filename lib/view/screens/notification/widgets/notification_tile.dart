import 'package:flutter/material.dart';

class NotificationTileWidget extends StatelessWidget {
  final int index;
  const NotificationTileWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(100),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Notification ${index + 1}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    content: const Text('About notification'),
                  );
                },
              );
            },
            title: Text(
              'Notification ${index + 1}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(
              'Click for Info',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
