// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:buybuddy/modules/onboarding/second_page.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 250,
                height: 250,
                child: Lottie.asset(
                  "assets/animations/79094-blue-shopping-cart.json",
                )),
            SizedBox(
              height: 30,
            ),
            Text(
              "Enjoy the maximum buying experience right now !",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontFamily: "Caprasimo"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: indigoDye,
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SecondPage(
                transitionAnimation: animation,
              ),
              transitionDuration: const Duration(seconds: 1),
            ),
          );
        },
        child: Icon(
          Icons.keyboard_arrow_right,
          color: ivory,
        ),
      ),
    );
  }
}
