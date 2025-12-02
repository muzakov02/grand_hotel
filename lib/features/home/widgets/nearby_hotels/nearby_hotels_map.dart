import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../models/nearby_hotel.dart';

class NearbyHotelsMap extends StatefulWidget {
  final List<NearbyHotel> hotels;
  final double userLatitude;
  final double userLongitude;

  const NearbyHotelsMap({super.key, required this.hotels, required this.userLatitude, required this.userLongitude});

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
    for (var hotel in widget.hotels) {
      _mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId(hotel.id),
          point: Point(latitude: hotel.coordinates.latitude, longitude: hotel.coordinates.longitude),
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/hotel_marker.png'),
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
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hotel.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('\$${hotel.price}/night • ${hotel.distance}km'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: YandexMap(
          onMapCreated: (controller) {
            _mapController = controller;
            _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: Point(latitude: widget.userLatitude, longitude: widget.userLongitude), zoom: 12.0),
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