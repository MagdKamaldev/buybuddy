import 'package:buybuddy/modules/home/checkout/location_screen.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/components/timeline_tile.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
            GestureDetector(
              onTap: () {
                navigateTo(context, SetLocationScreen());
              },
              child: MyTimeLineTile(
                isFirst: true,
                isLast: false,
                isPast: true,
                eventCard: Column(
                  children: [
                    Text(
                      "Pick the adress",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ivory),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Lottie.asset("assets/animations/adress.json"),
                    ),
                  ],
                ),
              ),
            ),
            MyTimeLineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: Column(
                children: [
                  Text(
                    "Payment",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ivory),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Lottie.asset("assets/animations/payment.json"),
                  ),
                ],
              ),
            ),
            MyTimeLineTile(
              isFirst: false,
              isLast: true,
              isPast: false,
              eventCard: Column(
                children: [
                  Text(
                    "Confirm phone",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ivory),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Lottie.asset("assets/animations/phone.json"),
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
