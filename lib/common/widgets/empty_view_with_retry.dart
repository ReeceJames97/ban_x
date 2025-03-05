import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyViewWithRetry extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;

  const EmptyViewWithRetry({
    Key? key,
    required this.onRetry,
    this.message = 'No items found',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset('assets/lotties/empty_box.json',
                width: 140,
                height: 130,
                animate: true,
                repeat: true,
                fit: BoxFit.fill),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: BanXColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}