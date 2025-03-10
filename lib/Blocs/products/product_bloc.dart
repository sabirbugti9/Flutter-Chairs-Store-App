import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Blocs/products/product_event.dart';
import 'package:shopping_app/Blocs/products/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProductEvent>(
      (event, emit) async {
        emit(ProductLoading());
        await Future.delayed(Duration(seconds: 1));
        final items = [
          {
            'image': 'assets/products/1.png',
            'name': 'Grey Chair',
            'price': '189.99',
            'color': const Color.fromARGB(255, 255, 232, 163),
          },
          {
            'image': 'assets/products/2.png',
            'name': 'Grey Soffa',
            'price': '200.00',
            'color': const Color.fromARGB(255, 226, 209, 255),
          },
          {
            'image': 'assets/products/3.png',
            'name': 'Green Chair',
            'price': '89.99',
            'color': const Color.fromARGB(255, 200, 186, 250),
          },
          {
            'image': 'assets/products/4.png',
            'name': 'Wood Chair',
            'price': '100.99',
            'color': const Color.fromARGB(255, 180, 230, 255),
          },
        ];
        emit(ProductLoaded(items));
      },
    );
  }
  double get totalPrice {
    return state.items.fold(0.0, (sum, item) {
      // Mengambil harga dan mengalikannya dengan jumlah
      double price =
          double.parse(item['price']); // pastikan price dalam bentuk angka
      int quantity = item['quantity'];
      return sum + (price * quantity);
    });
  }
}
