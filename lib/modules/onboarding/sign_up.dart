// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/signup/sign_up_cubit.dart';
import '../../cubit/signup/sign_up_states.dart';
import '../../shared/networks/cache_helper.dart';
import '../home/home_layout.dart';

class SignUp extends StatelessWidget {
  final Animation<double> transitionAnimation;
  SignUp({super.key, required this.transitionAnimation});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          if (state.loginModel.status!) {
            //sucessfully logged in ........................
            showCustomSnackBar(
                context, state.loginModel.message.toString(), Colors.green);
            //save start widget ........................
            CacheHelper.saveData(
              key: "start",
              value: "home",
            ).then((value) {
              //save token .................................
              CacheHelper.saveData(
                  key: "token", value: state.loginModel.data!.token.toString());
            }).then((value) {
              //go to home layout...........................
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => HomeLayout(),
                  ), (route) {
                return false;
              });
            });
          } else {
            showCustomSnackBar(
                context, state.loginModel.message.toString(), Colors.red);
          }
        }
      },
      builder: (context, state) => SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: transitionAnimation,
            curve: Interval(0, 0.5, curve: Curves.easeInOutCubic))),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Text(
              "Sign Up",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(children: [
                  SizedBox(
                    height: 30,
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
                    height: 20,
                  ),
                  defaultFormField(
                      context: context,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "password must not be empty";
                        }
                      },
                      suffixPressed: () {
                        SignUpCubit.get(context).changePassword();
                      },
                      isPassword: SignUpCubit.get(context).isPassword,
                      suffix: SignUpCubit.get(context).suffix,
                      label: "password",
                      prefix: Icons.password_sharp),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      context: context,
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      onSubmit: () {},
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "please confirm your password";
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return "passwords must match";
                        }
                      },
                      suffixPressed: () {
                        SignUpCubit.get(context).changePassword();
                      },
                      isPassword: SignUpCubit.get(context).isPassword,
                      suffix: SignUpCubit.get(context).suffix,
                      label: "Confirm Password",
                      prefix: Icons.password_sharp),
                  SizedBox(
                    height: 25,
                  ),
                  ConditionalBuilder(
                    condition: state is! SignUpLoadingState,
                    builder: (context) => defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            SignUpCubit.get(context).userSignUp(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                context: context);
                          }
                        },
                        context: context,
                        text: "Sign Up"),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
