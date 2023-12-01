import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/core/utils/app_asset.dart';

class OrderConfirmation extends StatelessWidget {
  final bool? success;

  const OrderConfirmation({super.key, this.success});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          success ?? false ? AppAsset.paymentSuccess : AppAsset.paymentFailure,
        ),
      ),
    );
  }
}
