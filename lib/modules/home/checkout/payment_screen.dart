import 'package:buybuddy/cubit/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "Payment",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Don't pay real money this is a trial app  ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16),
                ),
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Lottie.asset("assets/animations/payment_title.json")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: prussianBlue,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  CartCubit.get(context).getCartModel!.data!.total.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "EGP",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: prussianBlue.shade300),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              height: 70,
              child: GestureDetector(
                onTap: () => showCardSheet(context: context),
                child: Card(
                  color: ivory,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        const Spacer(),
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/card.png")),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 70,
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  color: ivory,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          "Cash ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset("assets/images/cash.png"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 70,
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  color: ivory,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          "Fawry",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset("assets/images/fawry.png")),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            defaultButton(
                function: () {},
                context: context,
                text: "Confirm Payment",
                height: MediaQuery.of(context).size.height * 0.08),
          ],
        ),
      ),
    );
  }
}
