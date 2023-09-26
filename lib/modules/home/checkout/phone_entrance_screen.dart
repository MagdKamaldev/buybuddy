// ignore_for_file: must_be_immutable
import 'package:buybuddy/cubit/app/app_cubit.dart';
import 'package:buybuddy/cubit/checkout/checkout_cubit.dart';
import 'package:buybuddy/cubit/checkout/checkout_states.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneEntrance extends StatelessWidget {
  PhoneEntrance({super.key});

  FocusNode focusNode = FocusNode();
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: Text(
            "Confirm phone number",
            style: theme.bodyLarge!.copyWith(color: ivory),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Please confirm your phone number to complete purchase !",
                style: theme.bodyLarge!.copyWith(fontSize: 17),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                  child: Image.asset("assets/images/unlock.png")),
              const Spacer(),
              IntlPhoneField(
                focusNode: focusNode,
                style: theme.titleMedium!.copyWith(fontSize: 18),
                initialCountryCode: 'EG',
                flagsButtonPadding: const EdgeInsets.all(10),
                dropdownTextStyle: theme.titleMedium!.copyWith(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: "phone",
                  labelStyle: theme.titleMedium!.copyWith(fontSize: 22),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (phone) {
                  phoneNumber = phone.completeNumber;
                },
                initialValue: AppCubit.get(context).userModel!.data!.phone!,
              ),
              const Spacer(),
              defaultButton(
                  function: () {
                    CheckOutCubit.get(context).phoneLogin(
                      context,
                      phoneNumber == ""
                          ? "+20${AppCubit.get(context).userModel!.data!.phone!}"
                          : phoneNumber,
                    );
                  },
                  context: context,
                  text: "Confirm Phone",
                  height: size.height * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}
