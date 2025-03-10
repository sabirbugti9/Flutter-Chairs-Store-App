abstract class CartEvent {}

class AddToCart extends CartEvent {
  Map<String, dynamic> item;

  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  Map<String, dynamic> item;

  RemoveFromCart(this.item);
}

class IncrementItem extends CartEvent {
  final Map<String, dynamic> item;

  IncrementItem(this.item);
}

class DecrementItem extends CartEvent {
  final Map<String, dynamic> item;

  DecrementItem(this.item);
}
