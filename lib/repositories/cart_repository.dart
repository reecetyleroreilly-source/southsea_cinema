import 'package:southsea_cinema/Models/CartItem.dart';

class CartRepository {
  CartRepository._internal();

  static final CartRepository instance = CartRepository._internal();

  final List<Cartitem> _items = [];

  List<Cartitem> getItems() {
    return List<Cartitem>.unmodifiable(_items);
  }

  void additem(Cartitem item) {
    _items.add(item);
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }



  int getTotalItems() {
    int total = 0;
    for (final Cartitem item in _items) {
      total += item.quantity;
    }
    return total;
  }

  int get totalItemCount {
    return getTotalItems();
  }

  double getSubtotal() {
    double sum = 0.0;
    for (final Cartitem item in _items) {
      sum += item.lineTotal;
    }
    return sum;
  }

  double getTotalDue() {
    return getSubtotal();
  }

  void clear() {
    _items.clear();
  }
}
