import 'package:buybuddy/cubit/checkout/checkout_cubit.dart';
import 'package:buybuddy/cubit/checkout/checkout_states.dart';
import 'package:buybuddy/modules/home/checkout/location_screen.dart';
import 'package:buybuddy/modules/home/checkout/payment_screen.dart';
import 'package:buybuddy/modules/home/checkout/phone_entrance_screen.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/components/timeline_tile.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CheckOutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            title: Text(
              "Checkout",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    navigateTo(context, PhoneEntrance());
                  },
                  child: MyTimeLineTile(
                    isFirst: true,
                    isLast: false,
                    isPast: cubit.phoneConfirmed,
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
                          child: Image.asset("assets/images/smartphone.png"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(context, SetLocationScreen());
                  },
                  child: MyTimeLineTile(
                    isFirst: false,
                    isLast: false,
                    isPast: cubit.adressConfirmed,
                    eventCard: Column(
                      children: [
                        Text(
                          "Adress",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: ivory),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Image.asset("assets/images/map.png"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(context, const PaymentScreen());
                  },
                  child: MyTimeLineTile(
                    isFirst: false,
                    isLast: true,
                    isPast: cubit.paymentDone,
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
                          child: Image.asset("assets/images/credit-card.png"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                defaultButton(
                    function: () {},
                    context: context,
                    text: "Place Order",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.07)
              ],
            ),
          ),
        );
      },
    );
  }
}
