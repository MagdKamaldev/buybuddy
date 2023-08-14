// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:buybuddy/modules/home/payment_screen.dart';
import 'package:buybuddy/modules/home/product_details.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/app/app_cubit.dart';
import '../../cubit/app/app_states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: ConditionalBuilder(
          builder: (context) => Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
                  itemCount: AppCubit.get(context)
                      .getCartModel!
                      .data!
                      .cartItems!
                      .length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => product(
                    AppCubit.get(context)
                        .getCartModel!
                        .data!
                        .cartItems![index]
                        .product,
                    context,
                    index,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  height: 85,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: indigoDye,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                        'Total Items : ${AppCubit.get(context).getCartModel!.data!.cartItems!.length}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 25, color: indigoDye)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 85,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: indigoDye,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                        'Total price : ${AppCubit.get(context).getCartModel!.data!.total} EGP',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 25, color: indigoDye)),
                  ),
                ),
                if (AppCubit.get(context)
                    .getCartModel!
                    .data!
                    .cartItems!
                    .isNotEmpty)
                  SizedBox(
                    height: 20,
                  ),
                if (AppCubit.get(context)
                    .getCartModel!
                    .data!
                    .cartItems!
                    .isNotEmpty)
                  defaultButton(
                      function: () {
                        navigateTo(context, PaymnetScreen());
                      },
                      context: context,
                      text: "Proceed to Checkout"),
                SizedBox(
                  height: 25,
                ),
              ]),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
          condition: AppCubit.get(context).getCartModel != null,
        ),
      ),
    );
  }

  Widget product(model, context, index) => GestureDetector(
        onTap: () {
          navigateTo(
              context,
              ProductDetails(
                index: index,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: prussianBlue, width: 1),
              borderRadius: BorderRadius.circular(13)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: indigoDye,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        bottomLeft: Radius.circular(13)),
                    child: Hero(
                      tag: "product_$index",
                      child: Image.network(
                        model.image.toString(),
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          model.name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: ivory),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: 1,
                        color: ivory,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "EGP  ${model.price.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: ivory),
                            ),
                            if (model.discount != 0)
                              Text(
                                model.oldPrice.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 12,
                                      color: ivory,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3,
                                      decorationColor: Colors.red[400],
                                    ),
                              ),
                            IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .changeFavourites(model.id!, context);
                                },
                                icon: Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
