import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../models/nearby_hotel.dart';

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
  late YandexMapController _mapController;
  final List<MapObject> _mapObjects = [];

  @override
  void initState() {
    super.initState();
    _createPlacemarks();
  }

  void _createPlacemarks() {
    _mapObjects.clear();

    _mapObjects.add(
      PlacemarkMapObject(
        mapId: const MapObjectId('user_location'),
        point: Point(
          latitude: widget.userLatitude,
          longitude: widget.userLongitude,
        ),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/user_marker.png'),
            scale: 0.2,
          ),
        ),
      ),
    );

    for (var hotel in widget.hotels) {
      _mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId('hotel_${hotel.id}'),
          point: Point(
            latitude: hotel.coordinates.latitude,
            longitude: hotel.coordinates.longitude,
          ),
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                  'assets/images/hotel_marker.png'),
              scale: 0.15,
            ),
          ),
          onTap: (self, point) => _showHotelInfo(hotel),
        ),
      );
    }
  }

  void _showHotelInfo(NearbyHotel hotel) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hotel.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  hotel.rating.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 16),
                Text(
                  '\$${hotel.price}/night',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2853AF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${hotel.distance.toStringAsFixed(1)} km away',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: YandexMap(
          onMapCreated: (controller) {
            _mapController = controller;
            _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: Point(
                    latitude: widget.userLatitude,
                    longitude: widget.userLongitude,
                  ),
                  zoom: 12.0,
                ),
              ),
            );
          },
          mapObjects: _mapObjects,
          onMapTap: (point) {},
        ),
      ),
    );
  }
}
