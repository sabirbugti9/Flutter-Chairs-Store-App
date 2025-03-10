import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Blocs/cart/cart_bloc.dart';
import 'package:shopping_app/Blocs/cart/cart_event.dart';

class ExploreProduct extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final Color color;
  const ExploreProduct({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.color,
  });

  @override
  State<ExploreProduct> createState() => _ExploreProductState();
}

class _ExploreProductState extends State<ExploreProduct> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // white border
          Container(
            height: 300,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),

          // product image
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: widget.color,
              ),
              child: Image.asset(widget.image),
            ),
          ),

          // small product image
          Positioned(
            bottom: 70,
            right: 75,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(1, 2)),
                  ]),
              child: Image.asset(widget.image),
            ),
          ),

          Positioned(
            bottom: 70,
            right: 20,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(1, 2)),
                  ]),
              child: Image.asset(widget.image),
            ),
          ),

          // favorite button
          Positioned(
            top: 15,
            right: 15,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: widget.color.withOpacity(0.5)),
                onPressed: () {},
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.black,
                )),
          ),

          // Product Information
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '\$${widget.price}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '14/20 Available',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // Add Button
          Positioned(
            bottom: 20,
            right: 10,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), backgroundColor: Colors.black),
                onPressed: () {
                  quantity++;

                  context.read<CartBloc>().add(AddToCart({
                        'name': widget.title,
                        'price': widget.price,
                        'image': widget.image,
                        'quantity': quantity,
                        'color': widget.color,
                      }));

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Added To Cart!'),
                    duration: Duration(seconds: 1),
                  ));
                },
                child: Icon(
                  size: 30,
                  Icons.add,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
