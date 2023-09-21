// ignore_for_file: must_be_immutable
import 'package:buybuddy/cubit/cart/cart_cubit.dart';
import 'package:buybuddy/models/payment_model.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '../../../shared/styles/colors.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<PaymentItem> items = [];

  @override
  void initState() {
    for (var item in CartCubit.get(context).getCartModel!.data!.cartItems!) {
      items.add(
        PaymentItem(
            amount: item.product!.price.toString(),
            label: item.product!.name.toString(),
            status: PaymentItemStatus.final_price),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var googlePlayButton = GooglePayButton(
      onPaymentResult: (result) =>
          showCustomSnackBar(context, "Payment Successful", Colors.green),
      paymentItems: items,
      type: GooglePayButtonType.buy,
      onError: (error) {
        showCustomSnackBar(context, error.toString(), Colors.red);
      },
      height: MediaQuery.of(context).size.height * 0.07,
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultGooglePay),
      width: double.infinity,
      loadingIndicator: const Center(child: CircularProgressIndicator()),
    );
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
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Image.asset("assets/images/smartphone.png")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: prussianBlue,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Amount :",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
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
            ),
            const Spacer(),
            googlePlayButton,
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
