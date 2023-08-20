// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:buybuddy/cubit/map/checkout_cubit.dart';
import 'package:buybuddy/modules/home/map_screen.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../cubit/map/checkout_states.dart';

class SetLocationScreen extends StatelessWidget {
  var buildingController = TextEditingController();
  var apartmentController = TextEditingController();
  var floorController = TextEditingController();
  var streetController = TextEditingController();
  var additionalDirectionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Payment",
                  //   style: Theme.of(context).textTheme.bodyLarge,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // SizedBox(
                  //   height: 70,
                  //   child: GestureDetector(
                  //     onTap: () => showCardSheet(context: context),
                  //     child: Card(
                  //       color: ivory,
                  //       child: Row(
                  //         children: [
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Container(
                  //             width: 30,
                  //             height: 30,
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               border: Border.all(color: indigoDye, width: 2),
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           Text(
                  //             "+ Add Card",
                  //             style: Theme.of(context).textTheme.titleMedium,
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           const Icon(Icons.credit_card)
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // SizedBox(
                  //   height: 70,
                  //   child: GestureDetector(
                  //     onTap: () {},
                  //     child: Card(
                  //       color: ivory,
                  //       child: Row(
                  //         children: [
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Container(
                  //             width: 30,
                  //             height: 30,
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               border: Border.all(color: indigoDye, width: 2),
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           Text(
                  //             "Cash on delivery",
                  //             style: Theme.of(context).textTheme.titleMedium,
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           const Icon(Icons.monetization_on),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.2,
                  // ),
                  Text(
                    "Set location on map",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  ConditionalBuilder(
                    condition: state is! ResquestPermissionWarningState,
                    fallback: (context) => Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Location Access",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "give the app location permissions in settings !",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                    builder: (context) => ConditionalBuilder(
                      condition:
                          CheckOutCubit.get(context).currentLatLong != null,
                      fallback: (context) => const SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator())),
                      builder: (context) => Column(
                        children: [
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
                                      mapType: MapType.normal,
                                      zoomControlsEnabled: false,
                                      zoomGesturesEnabled: true,
                                      initialCameraPosition:
                                          CheckOutCubit.get(context)
                                                      .orderLatLong ==
                                                  null
                                              ? CheckOutCubit.get(context)
                                                  .myPosition
                                              : CameraPosition(
                                                  zoom: 15.5,
                                                  target: LatLng(
                                                      CheckOutCubit.get(context)
                                                          .orderLatLong!
                                                          .latitude,
                                                      CheckOutCubit.get(context)
                                                          .orderLatLong!
                                                          .longitude),
                                                ),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        CheckOutCubit.get(context)
                                            .setMarkerCustomImage(context);
                                      },
                                      markers:
                                          CheckOutCubit.get(context).myMarkers,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: ivory.withOpacity(0.8)),
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Choose Another Location',
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    "Adress details",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.black, width: 1), // Border styling
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          defaultFormField(
                              controller: streetController,
                              type: TextInputType.streetAddress,
                              onSubmit: () {},
                              validate: () {},
                              label: "Street",
                              prefix: Icons.directions,
                              context: context),
                          const Spacer(),
                          defaultFormField(
                            controller: buildingController,
                            type: TextInputType.streetAddress,
                            onSubmit: () {},
                            validate: () {},
                            label: "Building name / number",
                            prefix: Icons.apartment,
                            context: context,
                          ),
                          const Spacer(),
                          defaultFormField(
                              controller: floorController,
                              type: TextInputType.streetAddress,
                              onSubmit: () {},
                              validate: () {},
                              label: "floor",
                              prefix: Icons.layers,
                              context: context),
                          const Spacer(),
                          defaultFormField(
                              controller: apartmentController,
                              type: TextInputType.streetAddress,
                              onSubmit: () {},
                              validate: () {},
                              label: "Apartment number",
                              prefix: Icons.house_rounded,
                              context: context),
                        ],
                      ),
                    ), // Replace with your desired child widget
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  defaultButton(
                      function: () {}, context: context, text: "Confirm")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
