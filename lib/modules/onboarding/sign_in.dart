// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable
import 'package:buybuddy/cubit/login/login_cubit.dart';
import 'package:buybuddy/cubit/login/login_states.dart';
import 'package:buybuddy/modules/home/home_layout.dart';
import 'package:buybuddy/modules/onboarding/sign_up.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/networks/cache_helper.dart';

class SignInPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
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
                  CupertinoPageRoute(builder: (context) => HomeLayout(),),
                  (route) {
                return false;
              });
            });
          } else {
            showCustomSnackBar(
                context, state.loginModel.message.toString(), Colors.red);
          }
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 165,
          title: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BuyBuddy",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: ivory),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset("assets/images/logo.png"))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "The faster you login the more you  find offers !",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: ashGrey, fontFamily: "Caprasimo"),
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  defaultFormField(
                    onSubmit: () {},
                    context: context,
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: "E-mail",
                    prefix: Icons.email,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return "Please enter your email adress";
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                      onSubmit: () {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      context: context,
                      controller: passwordController,
                      type: TextInputType.emailAddress,
                      label: "Password",
                      prefix: Icons.password_sharp,
                      suffix: LoginCubit.get(context).suffix,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "Password is too short";
                        }
                      },
                      isPassword: LoginCubit.get(context).isPassword,
                      suffixPressed: () {
                        LoginCubit.get(context).changePassword();
                      }),
                  SizedBox(
                    height: 55,
                  ),
                  ConditionalBuilder(
                    builder: (context) => defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      text: "Sign In",
                      context: context,
                    ),
                    condition: state is! LoginLoadingState,
                    fallback: (context) => CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: indigoDye,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "or",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: prussianBlue),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: indigoDye,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  defaultTextButton(
                      function: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SignUp(
                            transitionAnimation: animation,
                          ),
                          transitionDuration: const Duration(seconds: 1),
                        ));
                      },
                      text: "Sign Up",
                      context: context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
