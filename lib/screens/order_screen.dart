import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isDeliverySelected = true;
  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2F2D2C)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Order',
          style: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2F2D2C),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildDeliveryToggle(),
              const SizedBox(height: 24),
              _buildAddressSection(),
              const SizedBox(height: 20),
              const Divider(color: Color(0xFFEAEAEA), thickness: 1),
              const SizedBox(height: 20),
              _buildOrderItem(),
              const SizedBox(height: 20),
              Container(
                height: 4,
                color: const Color(0xFFF4F4F4),
                margin: const EdgeInsets.symmetric(horizontal: -30),
              ),
              const SizedBox(height: 20),
              _buildDiscountSection(),
              const SizedBox(height: 20),
              _buildPaymentSummary(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildDeliveryToggle() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isDeliverySelected = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _isDeliverySelected ? const Color(0xFFC67C4E) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Deliver',
                    style: GoogleFonts.sora(
                      color: _isDeliverySelected ? Colors.white : const Color(0xFF2F2D2C),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isDeliverySelected = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !_isDeliverySelected ? const Color(0xFFC67C4E) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Pick Up',
                    style: GoogleFonts.sora(
                      color: !_isDeliverySelected ? Colors.white : const Color(0xFF2F2D2C),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address',
          style: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF2F2D2C)),
        ),
        const SizedBox(height: 16),
        Text(
          'Jl. Kpg Sutoyo',
          style: GoogleFonts.sora(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF2F2D2C)),
        ),
        const SizedBox(height: 4),
        Text(
          'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
          style: GoogleFonts.sora(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xFF808080)),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSmallButton(icon: Icons.edit_note, text: 'Edit Address'),
            const SizedBox(width: 8),
            _buildSmallButton(icon: Icons.note_add_outlined, text: 'Add Note'),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallButton({required IconData icon, required String text}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: const Color(0xFF303336)),
      label: Text(
        text,
        style: GoogleFonts.sora(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xFF303336)),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFDEDEDE)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }

  Widget _buildOrderItem() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/I216_505_417_715.png',
            width: 54,
            height: 54,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Caffe Mocha', style: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('Deep Foam', style: GoogleFonts.sora(fontSize: 12, color: const Color(0xFF9B9B9B))),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            _buildQuantityButton(icon: Icons.remove, onPressed: () {
              if (_itemCount > 1) setState(() => _itemCount--);
            }),
            SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  '$_itemCount',
                  style: GoogleFonts.sora(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            _buildQuantityButton(icon: Icons.add, onPressed: () {
              setState(() => _itemCount++);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEAEAEA)),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF2F2D2C)),
      ),
    );
  }

  Widget _buildDiscountSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: Color(0xFFC67C4E)),
          const SizedBox(width: 12),
          Text(
            '1 Discount is applied',
            style: GoogleFonts.sora(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF2F2D2C)),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF2F2D2C)),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary',
          style: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF2F2D2C)),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Price', style: GoogleFonts.sora(fontSize: 14)),
            Text('\$ 4.53', style: GoogleFonts.sora(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Delivery Fee', style: GoogleFonts.sora(fontSize: 14)),
            Row(
              children: [
                Text(
                  '\$ 2.0',
                  style: GoogleFonts.sora(
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '\$ 1.0',
                  style: GoogleFonts.sora(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet, color: Color(0xFFC67C4E)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cash/Wallet', style: GoogleFonts.sora(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text('\$ 5.53', style: GoogleFonts.sora(color: const Color(0xFFC67C4E), fontWeight: FontWeight.w600, fontSize: 12)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push('/delivery');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC67C4E),
                padding: const EdgeInsets.symmetric(vertical: 21),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'Order',
                style: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}