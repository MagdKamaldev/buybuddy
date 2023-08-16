import 'package:buybuddy/cubit/map/checkout_cubit.dart';
import 'package:buybuddy/modules/home/map_screen.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../cubit/map/checkout_states.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {
        if (CheckOutCubit.get(context).servicesEnabled==true) {
          CheckOutCubit.get(context).getLatLong();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Text(
              "Checkout",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: state is GetLatLongSuccessState,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    child: GestureDetector(
                      onTap: () => showCardSheet(context: context),
                      child: Card(
                        color: ivory,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: indigoDye, width: 2),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "+ Add Card",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.credit_card)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: ivory,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: indigoDye, width: 2),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Cash on delivery",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.monetization_on),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Text(
                    "Set Delivery Location",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, const MapScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: GoogleMap(
                              scrollGesturesEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    CheckOutCubit.get(context)
                                        .currentLatLong!
                                        .latitude,
                                    CheckOutCubit.get(context)
                                        .currentLatLong!
                                        .longitude),
                                zoom: 12,
                              ),
                              mapType: MapType.normal,
                              zoomControlsEnabled: false,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: ivory.withOpacity(0.8)),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Choose Location',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
