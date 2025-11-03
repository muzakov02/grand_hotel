// Full Screen Map
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bloc/nearby_hotels/nearby_hotels_bloc.dart';
import '../../../../bloc/nearby_hotels/nearby_hotels_state.dart';

class FullMapScreen extends StatelessWidget {
  const FullMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NearbyHotelsBloc, NearbyHotelsState>(
        builder: (context, state) {
          if (state is NearbyHotelsLoaded) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.userLatitude, state.userLongitude),
                    zoom: 12.0,
                  ),
                  markers: state.hotels.map((hotel) {
                    return Marker(
                      markerId: MarkerId(hotel.id),
                      position: hotel.coordinates,
                      infoWindow: InfoWindow(
                        title: hotel.name,
                        snippet: '\$${hotel.price}/night',
                      ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                    );
                  }).toSet(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}