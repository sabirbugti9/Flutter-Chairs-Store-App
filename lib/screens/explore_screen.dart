import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Blocs/products/product_bloc.dart';
import 'package:shopping_app/Blocs/products/product_state.dart';
import 'package:shopping_app/models/explore_product.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // quantity
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoaded) {
          return Stack(
            children: [
              // background image
              
              SizedBox(
                height: 400,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.asset(
                    'assets/products/bg-1.jpg',
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.5),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 160,
                child: Text.rich(
                  TextSpan(
                    text: 'Explore',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                    children: [
                      TextSpan(
                        text: ' More',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 40),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top:220,
                child: Text(
                  'Add Style and Comfort to Your Home',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              // product explore item
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
              
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ExploreProduct(
                        title: item['name'],
                        image: item['image'],
                        price: item['price'],
                        color: item['color'],
                      ),
                    );
                  }),

              // new collection
              Positioned(
                right: 10,
                left: 10,
                bottom: 130,
                child: Container(
                  width: 300,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 2,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 2))
                      ]),
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New Collection',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('20% ongoing discount'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Trending
              Positioned(
                right: 10,
                left: 10,
                bottom: 30,
                child: Container(
                  width: 300,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 2,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 2))
                      ]),
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Trending',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('10% ongoing discount'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // product image
              Positioned(
                bottom: 133,
                right: 5,
                height: 120,
                child: Image.asset('assets/products/2.png'),
              ),
              // product image
              Positioned(
                bottom: 25,
                right: 5,
                height: 120,
                child: Image.asset('assets/products/4.png'),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      }),
    );
  }
}
