import 'package:buybuddy/shared/components/timeline_tile.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: ListView(
          children: [
            MyTimeLineTile(
              isFirst: true,
              isLast: false,
              isPast: true,
              eventCard: Text(
                "Pick the adress",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: ashGrey),
              ),
            ),
            MyTimeLineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: Text(
                "Payment",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: ashGrey),
              ),
            ),
            MyTimeLineTile(
              isFirst: false,
              isLast: true,
              isPast: false,
              eventCard: Text(
                "Confirm phone",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: ashGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
