// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable
import 'package:buybuddy/cubit/app/app_cubit.dart';
import 'package:buybuddy/cubit/app/app_states.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).userModel != null,
          builder: (context) {
            nameController.text = AppCubit.get(context).userModel!.data!.name!;
            emailController.text =
                AppCubit.get(context).userModel!.data!.email!;
            phoneController.text =
                AppCubit.get(context).userModel!.data!.phone!;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Update Your profile info ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      defaultFormField(
                          context: context,
                          controller: nameController,
                          type: TextInputType.name,
                          onSubmit: () {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "name must not be empty";
                            }
                          },
                          label: "Name",
                          prefix: Icons.person),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          onSubmit: () {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "email must not be empty";
                            }
                          },
                          label: "Email",
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          context: context,
                          controller: phoneController,
                          type: TextInputType.phone,
                          onSubmit: () {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "phone must not be empty";
                            }
                          },
                          label: "phone",
                          prefix: Icons.phone),
                      SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                          context: context,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text);
                            }
                          },
                          text: "update",
                          isUpperCase: true),
                      SizedBox(
                        height: 20,
                      ),
                      logoutButton(context),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
