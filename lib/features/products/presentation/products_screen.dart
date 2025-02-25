// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isFavorite = false;
  bool _isExpanded = false;
  String? _selectedSize = 'L';
  Color _selectedColor = Colors.grey;

  void _updateColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/arrow_back_icon.svg',
                      ),

                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Product_1.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Light Dress Bless',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Text(
                        ' 5.0 (7,932 reviews)',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    !_isExpanded
                        ? 'Its simple and elegant shape makes it perfect for those of you who like you who want minimalist clothes...'
                        : 'Its simple and elegant shape makes it perfect for those of you who like you who want minimalist clothes Read More...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(_isExpanded ? 'Read Less' : 'Read More'),
                  ),
                  const SizedBox(height: 20),
                  Text('Choose Size'),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children:
                          ['S', 'M', 'L', 'XL'].map((size) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: ChoiceChip(
                                label: Text(size),
                                selected: _selectedSize == size,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedSize = size;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Color'),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        ColorChip(
                          Colors.grey,
                          _selectedColor == Colors.grey,
                          _updateColor,
                        ),
                        ColorChip(
                          Colors.black,
                          _selectedColor == Colors.black,
                          _updateColor,
                        ),
                        ColorChip(
                          Colors.blue,
                          _selectedColor == Colors.blue,
                          _updateColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Add to Cart | \$100.99',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final Function(Color) onColorSelected;

  const ColorChip(
    this.color,
    this.isSelected,
    this.onColorSelected, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        label: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          onColorSelected(color);
        },
      ),
    );
  }
}
