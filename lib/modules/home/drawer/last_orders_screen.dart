import 'package:buybuddy/cubit/checkout/checkout_cubit.dart';
import 'package:buybuddy/cubit/checkout/checkout_states.dart';
import 'package:buybuddy/models/order_model.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CheckOutCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              centerTitle: true,
              title: Text(
                "Last orders",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: ivory),
              ),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) => parentItem(
                  item: cubit.orders[index],
                  theme: Theme.of(context).textTheme,
                  context: context),
              itemCount: cubit.orders.length,
            ));
      },
    );
  }

  Widget parentItem({
    required OrderModel item,
    required TextTheme theme,
    required BuildContext context,
  }) {
    var size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 600;
    String dateString = item.timestamp.toString();
    String formattedDate =
        DateFormat('dd-MM-yyyy / HH:mm').format(DateTime.parse(dateString));
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.15,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.adress,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyLarge!.copyWith(
                        fontSize:
                            isMobile ? size.width * 0.05 : size.width * 0.02,
                        color: prussianBlue),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Cost :   ",
                        style: theme.bodyLarge!.copyWith(
                            fontSize: isMobile
                                ? size.width * 0.05
                                : size.width * 0.02,
                            color: Colors.grey[700]),
                      ),
                      Text(
                        "${item.total.toString()} EGP",
                        style: theme.bodyLarge!.copyWith(
                            fontSize: isMobile
                                ? size.width * 0.05
                                : size.width * 0.02,
                            color: prussianBlue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total items :   ",
                        style: theme.bodyLarge!.copyWith(
                            fontSize: isMobile
                                ? size.width * 0.05
                                : size.width * 0.02,
                            color: Colors.grey[700]),
                      ),
                      Text(
                        item.cartItems.length.toString(),
                        style: theme.bodyLarge!.copyWith(
                            fontSize: isMobile
                                ? size.width * 0.05
                                : size.width * 0.02,
                            color: prussianBlue),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  formattedDate,
                  style: theme.titleSmall!
                      .copyWith(color: Colors.grey, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
