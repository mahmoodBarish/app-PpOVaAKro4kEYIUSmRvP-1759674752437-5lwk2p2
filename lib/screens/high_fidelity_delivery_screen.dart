import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package.google_fonts/google_fonts.dart';

class HighFidelityDeliveryScreen extends StatelessWidget {
  const HighFidelityDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Map Image
          Image.asset(
            'assets/images/216_52.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Map Markers
          Positioned(
            top: 211,
            left: MediaQuery.of(context).size.width * 0.4,
            child: const Icon(
              Icons.location_on,
              color: Color(0xFFC67C4E),
              size: 30,
            ),
          ),
          Positioned(
            top: 311,
            right: 25,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/I216_86_418_950.png',
                width: 24,
                height: 24,
              ),
            ),
          ),

          // Custom App Bar
          _buildAppBar(context),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomSheet(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAppBarButton(
                icon: Icons.arrow_back_ios_new,
                onTap: () {
                  context.pop();
                },
              ),
              _buildAppBarButton(
                icon: Icons.gps_fixed,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: const Color(0xFF242424), size: 20),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFE3E3E3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '10 minutes left',
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF242424),
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                style: GoogleFonts.sora(
                  fontSize: 12,
                  color: const Color(0xFFA2A2A2),
                ),
                children: const [
                  TextSpan(text: 'Delivery to '),
                  TextSpan(
                    text: 'Jl. Kpg Sutoyo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2A2A2A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildProgressBar(),
            const SizedBox(height: 16),
            _buildDeliveryStatusCard(),
            const SizedBox(height: 16),
            _buildDriverInfo(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: [
        _buildProgressSegment(isActive: true),
        _buildProgressSegment(isActive: true),
        _buildProgressSegment(isActive: true),
        _buildProgressSegment(isActive: false),
      ],
    );
  }

  Widget _buildProgressSegment({required bool isActive}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 4,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF35C07E) : const Color(0xFFE3E3E3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildDeliveryStatusCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE3E3E3)),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE3E3E3)),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/I216_65_418_950.png',
                width: 28,
                height: 28,
                color: const Color(0xFFC67C4E),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivered your order',
                  style: GoogleFonts.sora(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF242424),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'We will deliver your goods to you in the shortest possible time.',
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFFA2A2A2),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDriverInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/images/216_57.png',
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brooklyn Simmons',
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF242424),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Personal Courier',
                style: GoogleFonts.sora(
                  fontSize: 12,
                  color: const Color(0xFFA2A2A2),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE3E3E3)),
            ),
            child: const Icon(Icons.call_outlined, color: Color(0xFF2A2A2A)),
          ),
        ),
      ],
    );
  }
}