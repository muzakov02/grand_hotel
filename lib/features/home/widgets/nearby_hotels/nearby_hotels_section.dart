import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../bloc/nearby_hotels/nearby_hotels_bloc.dart';
import '../../../../bloc/nearby_hotels/nearby_hotels_state.dart';
import 'full_screen_map.dart';
import 'nearby_hotels_map.dart';

class NearbyHotelsSection extends StatelessWidget {
  const NearbyHotelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyHotelsBloc, NearbyHotelsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hotel Near You', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      if (state is NearbyHotelsLoaded) {
                        Get.to(() => const FullMapScreen());
                      }
                    },
                    child: const Text('Open Map', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (state is NearbyHotelsLoading)
              _buildLoadingMap()
            else if (state is NearbyHotelsLoaded)
              _buildMapView(state)
            else if (state is NearbyHotelsError)
                _buildErrorMap(state.message)
              else
                _buildLoadingMap(),
          ],
        );
      },
    );
  }

  Widget _buildLoadingMap() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey[200]),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildMapView(NearbyHotelsLoaded state) {
    return NearbyHotelsMap(hotels: state.hotels, userLatitude: state.userLatitude, userLongitude: state.userLongitude);
  }

  Widget _buildErrorMap(String message) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey[200]),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 8),
            Text(message, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}