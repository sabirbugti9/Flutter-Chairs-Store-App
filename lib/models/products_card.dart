import 'package:flutter/material.dart';

class ProductsCard extends StatelessWidget {
  final String image;
  final Color color;
  const ProductsCard({
    super.key,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: color,
            ),
            child: Transform.scale(scale: 0.7, child: Image.asset(image)),
          ),
          Positioned(
              top: 5,
              right: 3,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: color.withOpacity(0.8)),
                  onPressed: () {},
                  child: Icon(
                    Icons.open_in_new,
                    color: Colors.black,
                  ))),
        ],
      ),
    );
  }
}
