import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/widgets/basket_button.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/settings_button.dart';
import 'package:southsea_cinema/widgets/booking_button.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() {
    return _BasketScreenState();
  }
}

class _BasketScreenState extends State<BasketScreen> {
  String _confirmationMessage = '';

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Text(
          'Your Basket Is Empty',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLineItem(CartRepository cart, Cartitem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.quantity} x ${item.movie.name}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(item.movie.date),
              const SizedBox(
                height: 4,
              ),
              Text('£${item.lineTotal.toStringAsFixed(2)}'),
            ],
          )),
          IconButton(
              onPressed: () {
                setState(() {
                  cart.removeItem(index);
                });
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red))
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;

    if (emphasise) {
      style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    } else {
      style = const TextStyle(color: cinemaFontWhite);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: style,
          ),
          Text(
            value,
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _buildBasketList(CartRepository cart, List<Cartitem> items) {
    final List<Widget> children = [];

    children.add(const Text(
      'Your Basket',
      style: cinemaHeaderStyle,
    ));
    children.add(const SizedBox(
      height: 16,
    ));

    for (int index = 0; index < items.length; index++) {
      final Cartitem item = items[index];
      children.add(_buildLineItem(cart, item, index));
    }

    children.add(const SizedBox(
      height: 16,
    ));

    children.add(_buildTotalRow(
        'Item Subtotal', '£${cart.getSubtotal().toStringAsFixed(2)}'));

    children.add(
        _buildTotalRow('Total', '£${cart.getTotalDue().toStringAsFixed(2)}'));

    children.add(SizedBox(
      width: double.infinity,
      child: PrimaryButton(
          label: 'checkout',
          onPressed: () {
            // setState(() {
            //   cart.clear();
            //   _confirmationMessage = 'Your Movie is booked';
            // });

            _checkout(cart, items);
          }),
    ));

    if (_confirmationMessage.isEmpty) {
      children.add(const SizedBox(
        height: 12,
      ));

      children.add(Text(_confirmationMessage,
          style: const TextStyle(fontWeight: FontWeight.bold)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  String _buildSummary(List<Cartitem> items) {
    final List<String> parts = [];
    for (final Cartitem item in items) {
      parts.add('${item.quantity} X ${item.movie.name}');
    }
    return parts.join(', ');
  }

  String _formatDate(DateTime now) {
    final String day = now.day.toString().padLeft(2, '0');
    final String month = now.month.toString().padLeft(2, '0');
    final String hour = now.hour.toString().padLeft(2, '0');
    final String minute = now.minute.toString().padLeft(2, '0');

    return '$day/$month/${now.year} $hour:$minute';
  }

  Future<void> _checkout(CartRepository cart, List<Cartitem> items) async {
    final String summary = _buildSummary(items);
    final double total = cart.getTotalDue();
    final String date = _formatDate(DateTime.now());

    try {
      final MovieDataBase database = MovieDataBase.instance;
      final int bookingNumber = await database.getNextBookingNumber();
      final BookingRecord record = BookingRecord(
          bookingNumber: bookingNumber,
          summary: summary,
          total: total,
          date: date);

      await database.insertBooking(record);
      cart.clear();

      if (!mounted) {
        return;
      }
      setState(() {
        _confirmationMessage = 'Booking $bookingNumber saved';
      });
      Navigator.pushNamed(context, '/bookings');
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _confirmationMessage = 'Could not save your booking: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CartRepository cart = CartRepository.instance;
    final List<Cartitem> items = cart.getItems();
    final Widget content;
    if (items.isEmpty) {
      if (_confirmationMessage.isNotEmpty) {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmptyState(),
            const SizedBox(
              height: 12,
            ),
            Text(
              _confirmationMessage,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        );
      } else {
        content = _buildEmptyState();
      }
    } else {
      //  content = const Text('Basket list placeholder');
      content = _buildBasketList(cart, items);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        actions: const [BookingButton(), BasketButton(), SettingsButton()],
        iconTheme: const IconThemeData(color: cinemaBrand),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        //child: Text('Basket Placeholder'),
        child: content,
      ),
    );
  }
}
