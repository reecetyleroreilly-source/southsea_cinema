import 'package:flutter/material.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ModalRoute<dynamic>? modalRoute = ModalRoute.of(context);
        String currentRoute = '';

        if (modalRoute != null) {
          RouteSettings settings = modalRoute.settings;
          String? routeName = settings.name;
          if (routeName != null) {
            currentRoute = routeName;
          }
        }

        if (currentRoute != '/bookings') {
          Navigator.pushNamed(context, '/bookings');
        }
      },
      icon: const Icon(Icons.receipt_long),
    );
  }
}
