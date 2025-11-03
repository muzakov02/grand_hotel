import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:grand_hotel/bloc/nearby_hotels/nearby_hotels_bloc.dart';
import 'package:grand_hotel/bloc/nearby_hotels/nearby_hotels_state.dart';
import 'package:grand_hotel/models/nearby_hotel.dart';

import 'full_screen_map.dart';

class NearbyHotelsSection extends StatelessWidget {
  const NearbyHotelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyHotelsBloc, NearbyHotelsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hotel Near You',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (state is NearbyHotelsLoaded) {
                        Get.to(() => const FullMapScreen());
                      }
                    },
                    child: const Text(
                      'Open Map',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Map Container
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
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
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

// Google Maps Widget
class NearbyHotelsMap extends StatefulWidget {
  final List<NearbyHotel> hotels;
  final double userLatitude;
  final double userLongitude;

  const NearbyHotelsMap({
    super.key,
    required this.hotels,
    required this.userLatitude,
    required this.userLongitude,
  });

  @override
  State<NearbyHotelsMap> createState() => _NearbyHotelsMapState();
}

class _NearbyHotelsMapState extends State<NearbyHotelsMap> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    _markers = widget.hotels.map((hotel) {
      return Marker(
        markerId: MarkerId(hotel.id),
        position: hotel.coordinates,
        infoWindow: InfoWindow(
          title: hotel.name,
          snippet: '\$${hotel.price}/night • ${hotel.distance}km',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.userLatitude, widget.userLongitude),
            zoom: 12.0,
          ),
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: (controller) => _mapController = controller,
        ),
      ),
    );
  }
}

