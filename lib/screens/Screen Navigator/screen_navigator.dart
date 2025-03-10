import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/Blocs/cart/cart_bloc.dart';
import 'package:shopping_app/Blocs/cart/cart_state.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/explore_screen.dart';
import 'package:shopping_app/screens/home_screen.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({super.key});

  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  final PageController _pageController = PageController(initialPage: 0);
  int quantity = 0;

  int selectedIndex = 0;

  void navigateScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 700), curve: Curves.slowMiddle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            children: [
              HomeScreen(),
              ExploreScreen(),
              CartScreen(),
            ],
          ),

          // logo
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
            child: Row(
              children: [
                Icon(
                  Icons.chair_rounded,
                  size: 50,
                  color: selectedIndex == 0 ? Colors.black : Colors.white,
                ),

                Spacer(),

                // search button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? Colors.white
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search,
                      color: selectedIndex == 0
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // cart button
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.8,
                          minChildSize: 0.5,
                          maxChildSize: 0.8,
                          builder: (context, scrollController) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              child: Column(
                                children: [
                                  // handle bar for swipe down indicator
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 5,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: CartScreen(
                                    scrollController: scrollController,
                                  )),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      final totalItems = context.read<CartBloc>().totalItems;

                      return Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: selectedIndex == 0
                                  ? Colors.black
                                  : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.shopping_basket,
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          if (totalItems > 0)
                            Positioned(
                              right: 1,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  totalItems.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // navigation button
          Positioned(
            bottom: 20,
            right: 70,
            left: 70,
            child: Container(
              width: 200,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.slowMiddle,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: selectedIndex == 0 ? Colors.white : Colors.black,
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () => navigateScreen(0),
                      icon: Icon(Icons.home),
                      color: selectedIndex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.slowMiddle,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () => navigateScreen(1),
                      icon: Icon(Icons.explore),
                      color: selectedIndex == 1 ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
