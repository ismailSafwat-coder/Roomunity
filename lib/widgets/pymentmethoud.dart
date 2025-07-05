import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodsCard extends StatelessWidget {
  const PaymentMethodsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'طرق الدفع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Payment methods row
          Column(
            children: [
              pymetbuildercard(SvgPicture.asset('images/svg/Tabby-01.svg'),
                  Colors.green, 'قصتها على 4 بدون أي فوائد أو رسوم'),
              pymetbuildercard(SvgPicture.asset('images/svg/tamara.svg'),
                  Colors.green, 'قصتها على 4 بدون أي فوائد أو رسوم'),
              pymetbuildercard(SvgPicture.asset('images/svg/Qitaf-01.svg'),
                  Colors.green, 'قصتها على 4 بدون أي فوائد أو رسوم'),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Container pymetbuildercard(Widget icon, Color? color, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(height: 50, width: 80, child: icon),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod({
    required Widget icon,
    required String name,
    required String promo,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: icon,
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          promo,
          style: TextStyle(
            fontSize: 10,
            color: Colors.green[700],
          ),
        ),
      ],
    );
  }
}
