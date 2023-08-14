import 'package:buybuddy/cubit/app/app_cubit.dart';
import 'package:buybuddy/cubit/app/app_states.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymnetScreen extends StatelessWidget {
  const PaymnetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Text(
              "Checkout",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pay with :",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 70,
                  child: GestureDetector(
                    onTap: () => showCardSheet(context: context),
                    child: Card(
                      color: ivory,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: indigoDye, width: 2),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "+ Add Card",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.credit_card)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 70,
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      color: ivory,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: indigoDye, width: 2),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Cash on delivery",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.monetization_on)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
