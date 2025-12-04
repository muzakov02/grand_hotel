import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/nearby_hotels/nearby_hotels_bloc.dart';
import '../../../../bloc/nearby_hotels/nearby_hotels_state.dart';
import 'nearby_hotels_map.dart';

class NearbyHotelsSection extends StatelessWidget {
  const NearbyHotelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyHotelsBloc, NearbyHotelsState>(
      builder: (context, state) {
        if (state is NearbyHotelsLoaded) {
        } else if (state is NearbyHotelsError) {}

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hotel Near You',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (state is NearbyHotelsLoaded) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NearbyHotelsMap(
                            hotels: state.hotels,
                            userLatitude: state.userLatitude,
                            userLongitude: state.userLongitude,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Open Map',
                    style: TextStyle(color: Color(0xFF2853AF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildMapView(NearbyHotelsLoaded state) {
    return NearbyHotelsMap(
      hotels: state.hotels,
      userLatitude: state.userLatitude,
      userLongitude: state.userLongitude,
    );
  }

  Widget _buildErrorMap(String message) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
