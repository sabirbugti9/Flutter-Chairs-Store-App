import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_app/Blocs/cart/cart_bloc.dart';
import 'package:shopping_app/Blocs/cart/cart_event.dart';
import 'package:shopping_app/Blocs/cart/cart_state.dart';

class CartScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const CartScreen({Key? key, this.scrollController}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 245, 255),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        double totalPrice = state.items.fold(0.0, (sum, item) {
          double price = double.parse(item['price']);
          int quantity = item['quantity'];
          return sum + (price * quantity);
        });
        return Stack(
          children: [
            ListView.builder(
                controller: ScrollController(),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];

                  return Slidable(
                    endActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                          flex: 1,
                          borderRadius: BorderRadius.circular(50),
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (context) {
                            context.read<CartBloc>().add(RemoveFromCart(item));
                          }),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ]),
                        child: ListTile(
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: item['color'], // Warna latar belakang
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Transform.scale(
                              scale: 0.9, // Skala gambar
                              child:
                                  Image.asset(item['image'], fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(
                            item['name'],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('\$${item['price']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Tombol decrement
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(DecrementItem(item));
                                },
                                icon: Icon(Icons.remove),
                              ),

                              // Jumlah
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: Text(
                                  item['quantity'].toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),

                              // Tombol increment
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(IncrementItem(item));
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Container(
                  height: 90,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child:
                        // Checkout Total items
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            Text(
                              'Total :',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        // total price
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        );
      }),
    );
  }
}
