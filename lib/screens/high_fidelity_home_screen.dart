import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HighFidelityHomeScreen extends StatefulWidget {
  const HighFidelityHomeScreen({super.key});

  @override
  _HighFidelityHomeScreenState createState() => _HighFidelityHomeScreenState();
}

class _HighFidelityHomeScreenState extends State<HighFidelityHomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All Coffee', 'Machiato', 'Latte', 'Americano'];
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopSection(),
            _buildMainContent(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF111111), Color(0xFF313131)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: GoogleFonts.sora(
                            color: const Color(0xFFA2A2A2),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Bilzen, Tanjungbalai',
                              style: GoogleFonts.sora(
                                color: const Color(0xFFD8D8D8),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFFD8D8D8),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Profile image would go here if available in JSON
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.sora(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search coffee',
                          hintStyle: GoogleFonts.sora(color: const Color(0xFFA2A2A2)),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          filled: true,
                          fillColor: const Color(0xFF292929),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC57C4E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 211,
          left: 0,
          right: 0,
          child: _buildBanner(),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/216_258.png',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 15,
              left: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFED4C4C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Promo',
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Buy one get one\nFREE',
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      backgroundColor: const Color(0xFF111111).withOpacity(0.5),
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

  Widget _buildMainContent() {
    final List<Product> products = [
      Product('Caffe Mocha', 'Deep Foam', '4.53', 'assets/images/I216_192_417_715.png', '4.8'),
      Product('Flat White', 'Espresso', '3.53', 'assets/images/I216_208_417_717.png', '4.8'),
      Product('Caffe Panna', 'Ice/Hot', '5.53', 'assets/images/I216_224_417_718.png', '4.8'),
      Product('Mocha Fusi', 'Ice/Hot', '7.53', 'assets/images/I216_240_417_716.png', '4.8'),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
      child: Column(
        children: [
          _buildCategoryChips(),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _ProductCard(product: products[index]);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedCategoryIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFC57C4E) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _categories[index],
                  style: GoogleFonts.sora(
                    color: isSelected ? Colors.white : const Color(0xFF2F2D2C),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 84,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.home, 0),
          _buildBottomNavItem(Icons.favorite, 1),
          _buildBottomNavItem(Icons.shopping_bag, 2),
          _buildBottomNavItem(Icons.notifications, 3),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, int index) {
    bool isSelected = _bottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _bottomNavIndex = index;
        });
        if (index == 2) {
          context.push('/order');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFC57C4E) : const Color(0xFFA2A2A2),
            size: 28,
          ),
          if (isSelected) ...[
            const SizedBox(height: 4),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: Color(0xFFC57C4E),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String subtitle;
  final String price;
  final String imagePath;
  final String rating;

  Product(this.name, this.subtitle, this.price, this.imagePath, this.rating);
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/detail_item');
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product.imagePath,
                    height: 132,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product.rating,
                          style: GoogleFonts.sora(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.name,
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2F2D2C),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.subtitle,
                style: GoogleFonts.sora(
                  fontSize: 12,
                  color: const Color(0xFFA2A2A2),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${product.price}',
                    style: GoogleFonts.sora(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2F4B4E),
                    ),
                  ),
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC57C4E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {},
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