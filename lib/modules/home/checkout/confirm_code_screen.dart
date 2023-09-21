// ignore_for_file: must_be_immutable
import 'package:buybuddy/cubit/checkout/checkout_cubit.dart';
import 'package:buybuddy/cubit/checkout/checkout_states.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmCode extends StatelessWidget {
  final String number;
  ConfirmCode({super.key, required this.number});

  String code = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            title: Text(
              "Confirm Code",
              style: theme.bodyLarge!.copyWith(color: ivory),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              child: Column(children: [
                Text(
                  "Please write the OTP code sent via SMS !",
                  style: theme.bodyLarge!
                      .copyWith(fontSize: 16, color: prussianBlue),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                    width: size.width * 0.3,
                    height: size.height * 0.15,
                    child: Image.asset("assets/images/unlock.png")),
                SizedBox(
                  height: size.height * 0.15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm Code",
                    style: theme.bodyLarge,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: prussianBlue, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            code = code + value;
                          }
                        },
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: prussianBlue, width: 1),
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add border radius
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            code = code + value;
                          }
                        },
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: prussianBlue, width: 1),
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add border radius
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            code = code + value;
                          }
                        },
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: prussianBlue, width: 1),
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add border radius
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            code = code + value;
                          }
                        },
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: prussianBlue, width: 1),
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add border radius
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            code = code + value;
                          }
                        },
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: prussianBlue, width: 1),
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add border radius
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            code = code + value;
                          }
                        },
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                Text(
                  '${CheckOutCubit.get(context).remainingDuration.inSeconds} Seconds Remaining',
                  style: theme.titleMedium!.copyWith(color: ashGrey.shade900),
                ),
                const Spacer(),
                defaultButton(
                    function: () {
                      // CheckOutCubit.get(context).stopTimer();
                      CheckOutCubit.get(context).confirmPhoneNumber(
                          number: number,
                          code: code,
                          context: context,
                          );
                    },
                    context: context,
                    text: "Confirm Code"),
                SizedBox(
                  height: size.height * 0.07,
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
