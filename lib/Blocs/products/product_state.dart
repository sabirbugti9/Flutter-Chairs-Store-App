abstract class ProductState {
  get items => null;
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Map<String, dynamic>> items;

  ProductLoaded(this.items);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
