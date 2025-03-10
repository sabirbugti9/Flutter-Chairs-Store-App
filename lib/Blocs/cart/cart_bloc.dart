import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Blocs/cart/cart_event.dart';
import 'package:shopping_app/Blocs/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddToCart>(
      (event, emit) {
        final updatedItems = state.items;
        final existingUpdatedItems = updatedItems
            .indexWhere((item) => item['name'] == event.item['name']);
        if (existingUpdatedItems != -1) {
          updatedItems[existingUpdatedItems]['quantity'] +=
              1; // Increase quantity if item already exists
        } else {
          updatedItems.add(event.item);
        }
        emit(CartState(updatedItems));
      },
    );

    on<RemoveFromCart>(
      (event, emit) {
        final updatedItems = state.items;
        updatedItems.remove(event.item);
        emit(CartState(updatedItems));
      },
    );

    on<IncrementItem>(
      (event, emit) {
        final updatedItems = state.items;
        final itemIndex = updatedItems
            .indexWhere((item) => item['name'] == event.item['name']);
        if (itemIndex != -1) {
          updatedItems[itemIndex]['quantity'] += 1;
          emit(CartState(List.from(updatedItems)));
        }
      },
    );

    on<DecrementItem>(
      (event, emit) {
        final updatedItems = state.items;
        final itemIndex = updatedItems
            .indexWhere((item) => item['name'] == event.item['name']);
        if (itemIndex != -1) {
          updatedItems[itemIndex]['quantity'] -= 1;
          emit(CartState(List.of(updatedItems)));
        }
      },
    );
  }
  int get totalItems {
    return state.items.fold(0, (sum, item) => sum + item['quantity'] as int);
  }

  get totalCart => null;
}
