import 'package:flutter/material.dart';

class SearchWindow extends StatelessWidget {
  final Function(String) searchProducts;

  const SearchWindow({required this.searchProducts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search products',
                  border: InputBorder.none,
                ),
                onChanged: (query) => searchProducts(query),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
