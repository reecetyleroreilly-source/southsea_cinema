import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/Models/CartItem.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/widgets/basket_button.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

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
                '£${item.quantity} x ${item.movie.name}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text('£${item.LineTotal.toStringAsFixed(2)}'),
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
            setState(() {
              cart.clear();
              _confirmationMessage = 'Your Movie is booked';
            });
          }),
    ));
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
      content = const Text('Basket list placeholder');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        actions: const [BasketButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        //child: Text('Basket Placeholder'),
        child: content,
      ),
    );
  }
}
