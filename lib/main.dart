import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Blocs/cart/cart_bloc.dart';
import 'package:shopping_app/Blocs/products/product_bloc.dart';
import 'package:shopping_app/Blocs/products/product_event.dart';
import 'package:shopping_app/screens/Screen%20Navigator/screen_navigator.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => ProductBloc()..add(LoadProductEvent())),
    BlocProvider(create: (context) => CartBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ScreenNavigator(),
    );
  }
}
