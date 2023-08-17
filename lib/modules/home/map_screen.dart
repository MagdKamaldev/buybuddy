import 'dart:async';
import 'package:buybuddy/cubit/map/checkout_cubit.dart';
import 'package:buybuddy/cubit/map/checkout_states.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    CheckOutCubit.get(context).getLatLong();
    super.initState();
  }

  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Text(
              "Choose Location",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: ivory),
            ),
            centerTitle: true,
          ),
          body: GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            initialCameraPosition: CheckOutCubit.get(context).myPosition,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId('userLocationMarker'),
                position: LatLng(
                  CheckOutCubit.get(context).currentLatLong!.latitude,
                  CheckOutCubit.get(context).currentLatLong!.longitude,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor
                    .hueAzure), // You can customize the marker icon
              ),
            },
          ),
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: prussianBlue,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: TextButton(
                        onPressed: () {
                          LatLng latLng = LatLng(
                              CheckOutCubit.get(context)
                                  .currentLatLong!
                                  .latitude,
                              CheckOutCubit.get(context)
                                  .currentLatLong!
                                  .longitude);
                          mapController!.animateCamera(CameraUpdate.newLatLng(
                            latLng,
                          ));
                        },
                        child: Text(
                          "Current Location",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: ivory),
                        )),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {},
            child: Container(
              color: indigoDye,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.075,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Confirm",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: ivory),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
