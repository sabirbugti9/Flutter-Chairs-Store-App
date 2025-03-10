import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Blocs/products/product_bloc.dart';
import 'package:shopping_app/Blocs/products/product_state.dart';
import 'package:shopping_app/models/products_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 245, 255),
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoaded) {
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                final items = state.items[index];

                return Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopTitle(),
                      _customProducts(items, state),
                      LastProduct(items: items),
                    ],
                  ),

                );
              });
        }
        return Center(
          child: Text('ERROR'),
        );
      }),
    );
  }























  Padding _customProducts(Map<String, dynamic> items, ProductLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            final item = state.items[index];

            return ProductsCard(
              image: item['image'],
              color: item['color'],
            );
          }),
    );
  }
}

class LastProduct extends StatelessWidget {
  const LastProduct({
    super.key,
    required this.items,
  });

  final Map<String, dynamic> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 465,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Column(
          children: [
            // product name & icon open_in_new
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    items['name'],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: items['color'],
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.open_in_new,
                        color: Colors.black,
                      ))
                ],
              ),
            ),

            // product image
            Image.asset(items['image'])
          ],
        ),
      ),
    );
  }
}

class TopTitle extends StatelessWidget {
  const TopTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Welcome back! Sabir',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Text('Experience Comfort with', style: TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Our Chairs',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
        ),
      ],
    );
  }
}
