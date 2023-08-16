// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:buybuddy/cubit/app/app_states.dart';
import 'package:buybuddy/cubit/cart/cart_cubit.dart';
import 'package:buybuddy/cubit/cart/cart_states.dart';
import 'package:buybuddy/models/home_model.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/app/app_cubit.dart';

class ProductDetails extends StatefulWidget {
  final int index;
  const ProductDetails({required this.index});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        AppCubit.get(context).homeModel!.data!.products[widget.index];
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          title: Text(
            product.name.toString(),
            maxLines: 3,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Hero(
                    tag: "product_${widget.index}",
                    child: Image.network(product.image.toString())),
              ),
              Container(
                width: double.infinity,
                color: prussianBlue,
                height: 5,
              ),
              Container(
                color: indigoDye,
                width: double.infinity,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 30, right: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Old Price :",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ivory),
                          ),
                          Text(
                            product.oldPrice.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ivory),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount :",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ivory),
                          ),
                          Text(
                            "${product.discount.toString()} %",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ivory),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price :",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ivory),
                          ),
                          Text(
                            product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ivory),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        color: prussianBlue,
                        height: 5,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Shipped in 2 days !",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ivory),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: prussianBlue,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: BlocConsumer<CartCubit, CartStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return ConditionalBuilder(
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                      condition: state is! AddToCartLoadingState,
                      builder: (context) => defaultButton(
                          function: () {
                            CartCubit.get(context)
                                .addToCart(product.id!, context);
                          },
                          context: context,
                          text: "Add / Remove from Cart"),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                color: prussianBlue,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: indigoDye,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text('Full Description',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 35, color: indigoDye)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    product.description.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ]),
              ),
              Container(
                width: double.infinity,
                height: 150,
                color: indigoDye,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Shipped And Deliverd By : ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ivory),
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
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/logo.png")),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
