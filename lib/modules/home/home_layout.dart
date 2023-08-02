// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:buybuddy/cubit/app/app_cubit.dart';
import 'package:buybuddy/cubit/app/app_states.dart';
import 'package:buybuddy/modules/home/search_screen.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Good ${AppCubit.get(context).welcomeText} !",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: ivory, fontSize: 18),
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: ashGrey,
                  ),
                  child: IconButton(
                    color: prussianBlue,
                    iconSize: 20,
                    icon: Icon(Icons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                  ),
                )
              ],
            ),
            toolbarHeight: 80,
          ),
          body:
              AppCubit.get(context).screens[AppCubit.get(context).screenindex!],
          bottomNavigationBar: Container(
            color: indigoDye,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: GNav(
                tabBorderRadius: 20,
                onTabChange: (index) =>
                    AppCubit.get(context).changeScreen(index),
                backgroundColor: indigoDye,
                color: ashGrey,
                activeColor: prussianBlue,
                tabBackgroundColor: ashGrey,
                selectedIndex: AppCubit.get(context).screenindex!,
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: "favourites",
                  ),
                  GButton(
                    icon: Icons.shopping_cart,
                    text: "Cart",
                  ),
                  GButton(
                    icon: Icons.person,
                    text: "Profile",
                  ),
                ],
                gap: 8,
              ),
            ),
          ),
        );
      },
    );
  }
}
