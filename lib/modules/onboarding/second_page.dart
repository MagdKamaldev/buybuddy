// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructorsimport 'package:buybuddy/shared/constants.dart';, prefer_const_literals_to_create_immutables
import 'package:buybuddy/modules/onboarding/sign_in.dart';
import 'package:buybuddy/shared/networks/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../shared/styles/colors.dart';

class SecondPage extends StatelessWidget {
  final Animation<double> transitionAnimation;
  const SecondPage({super.key, required this.transitionAnimation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: AnimatedBuilder(
              animation: transitionAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1, 0),
                    end: Offset(0, 0),
                  ).animate(CurvedAnimation(
                      parent: transitionAnimation,
                      curve: Interval(0, 0.5, curve: Curves.easeInOutCubic))),
                  child: child,
                );
              },
              child: Container(
                width: double.infinity,
                color: alabster,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                              "assets/animations/90549-voucher.json")),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Sign up now to get vouchers and discounts",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontFamily: "Caprasimo"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: prussianBlue,
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: transitionAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1, 0),
                    end: Offset(0, 0),
                  ).animate(CurvedAnimation(
                      parent: transitionAnimation,
                      curve: Interval(0.5, 1, curve: Curves.easeInOutCubic))),
                  child: child,
                );
              },
              child: Container(
                width: double.infinity,
                color: alabster,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: Lottie.asset(
                            "assets/animations/99271-food-out-for-delivery.json"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Free delivery is provided for the first 5 orders",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontFamily: "Caprasimo"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: indigoDye,
        onPressed: () {
          CacheHelper.saveData(key: "start", value: "signIn",);
           Navigator.of(context).pushAndRemoveUntil(
                 CupertinoPageRoute(builder: (context)=>SignInPage()), (route) {
                return false;
              });
        },
        label: Text(
          "Sign Up  /  In",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ivory),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
