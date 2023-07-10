// ignore_for_file: prefer_const_constructors
import 'package:buybuddy/shared/networks/cache_helper.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/onboarding/sign_in.dart';

Widget defaultButton({
  double height = 52,
  double width = double.infinity,
  bool isUpperCase = false,
  double radius = 13.0,
  required VoidCallback function,
  required BuildContext context,
  required String text,
}) =>
    Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: indigoDye,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: ivory, fontSize: 16),
          ),
        ));

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  required BuildContext context,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
        ));

// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   required Function onSubmit,
//   required Function validate,
//   bool isPassword = false,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   Function? suffixPressed,
//   bool isClickable = true,
//   BuildContext? context,
// }) =>
//     TextFormField(
//       validator: (value) {
//         return validate(value);
//       },
//       controller: controller,
//       keyboardType: type,
//       enabled: isClickable,
//       obscureText: isPassword,
//       onFieldSubmitted: (s) {
//         onSubmit();
//       },
//       style: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.normal,
//       ),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle:
//             Theme.of(context!).textTheme.titleMedium!.copyWith(fontSize: 16),
//         prefixIcon: Icon(
//           prefix,
//           color: prussianBlue,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//                 icon: Icon(
//                   suffix,
//                 ),
//                 onPressed: () {
//                   suffixPressed!();
//                 },
//               )
//             : null,
//         border: OutlineInputBorder(),
//       ),
//     );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onSubmit,
  required Function validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        validator: (value) {
          return validate(value);
        },
        controller: controller,
        keyboardType: type,
        enabled: isClickable,
        obscureText: isPassword,
        onFieldSubmitted: (s) {
          onSubmit();
        },
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
          prefixIcon: Icon(
            prefix,
            color: prussianBlue,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                  ),
                  onPressed: () {
                    suffixPressed!();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Set the desired border radius value
          ),
        ),
      ),
      SizedBox(height: 5),
    ],
  );
}

void showCustomSnackBar(
    BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 2),
    ),
  );
}



void navigateTo(context, widget) => Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, CupertinoPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget logoutButton(context) => defaultButton(
    function: () {
      CacheHelper.removeData(key: "token").then((value) {
        CacheHelper.saveData(key: "start", value: "signIn");
      }).then((value) {
        navigateAndFinish(context, SignInPage());
      });
    },
    context: context,
    text: "Sign out");
