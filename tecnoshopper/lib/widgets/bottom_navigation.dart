import 'package:flutter/material.dart';
import 'package:flutter_ces/styles/styles_home.dart';

class Bottom extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onAccountPressed;
  final VoidCallback onCartPressed;

  const Bottom({
    required this.onSearchChanged,
    required this.onAccountPressed,
    required this.onCartPressed,
    Key? key,
  }) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  bool _showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      alignment: Alignment.center,
      width: double.infinity,
      height: _showSearchBar ? 150 : 100,
      decoration: const BoxDecoration(
        color: HomeStyles.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          if (_showSearchBar)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  onChanged: widget.onSearchChanged,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home,
                    color: HomeStyles.iconColor, size: HomeStyles.iconSize),
              ),
              IconButton(
                onPressed: () =>
                    setState(() => _showSearchBar = !_showSearchBar),
                icon: Icon(Icons.search,
                    color: HomeStyles.iconColor, size: HomeStyles.iconSize),
              ),
              IconButton(
                onPressed: widget.onAccountPressed,
                icon: Icon(Icons.account_circle_outlined,
                    color: HomeStyles.iconColor, size: HomeStyles.iconSize),
              ),
              IconButton(
                onPressed: widget.onCartPressed,
                icon: Icon(Icons.shopping_cart_outlined,
                    color: HomeStyles.iconColor, size: HomeStyles.iconSize),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
