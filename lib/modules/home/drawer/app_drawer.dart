import 'package:buybuddy/cubit/checkout/checkout_cubit.dart';
import 'package:buybuddy/modules/home/drawer/last_orders_screen.dart';
import 'package:buybuddy/modules/home/drawer/settings_screen.dart';
import 'package:buybuddy/modules/onboarding/sign_in.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/networks/cache_helper.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: ashGrey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(context, BranchDetails());
                  },
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Profile",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: prussianBlue, fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.person,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(context, const Orders());
                    CheckOutCubit.get(context).fetchOrdersFromCache();
                  },
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Orders",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: prussianBlue, fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.history,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
                GestureDetector(
                  onTap: () {
                    navigateTo(context, SettingsScreen());
                  },
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "User Settings",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: prussianBlue, fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.settings,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Privacy Policy",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: prussianBlue, fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.privacy_tip,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "About us",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: prussianBlue, fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.business,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
                GestureDetector(
                  onTap: () {
                    CacheHelper.removeData(key: "token").then((value) {
                      CacheHelper.saveData(key: "start", value: "signIn");
                    }).then((value) {
                      navigateAndFinish(context, SignInPage());
                    });
                  },
                  child: Container(
                    height: size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Logout",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: prussianBlue, fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.logout,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            color: indigoDye,
            child: Column(
              children: [
                const SizedBox(
                  height: 17,
                ),
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
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset("assets/images/logo.png")),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
