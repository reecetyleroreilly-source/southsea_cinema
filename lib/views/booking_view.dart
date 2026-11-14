import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/widgets/basket_button.dart';
import 'package:southsea_cinema/widgets/booking_button.dart';
import 'package:southsea_cinema/widgets/settings_button.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() {
    return _BookingViewState();
  }
}

class _BookingViewState extends State<BookingView> {
  List<BookingRecord> _booking = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      body = Center(child: Text(_errorMessage));
    } else if (_booking.isEmpty) {
      body = const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: Text(
            'No bookings yet',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    else {
      body = ListView.builder(
        itemCount: _booking.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBookCard(_booking[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
        actions: const [BookingButton(), BasketButton(), SettingsButton()],
      ),
      body: body,
    );

    //return body;
  }

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      final List<BookingRecord> booking =
          await MovieDataBase.instance.getAllbookings();
      if (!mounted) {
        return;
      }
      setState(() {
        _booking = booking;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Could not load booking: ';
        _loading = false;
      });
    }
  }

  Widget _buildBookCard(BookingRecord booking) {
    return Card(
      color: Color(0xFF1B1E28),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${booking.bookingNumber}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('£${booking.total.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 4),
            Text(booking.summary),
            const SizedBox(height: 4),
            Text(
              booking.date,
              style: const TextStyle(fontSize: 12, color:cinemaFontWhite),
            ),
          ],
        ),
      ),
    );
  }
}
