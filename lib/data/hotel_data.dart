// data/hotel_data.dart
import 'package:grand_hotel/models/full_hotel.dart';

class HotelData {
  static List<FullHotel> getMostPopularHotels() {
    return [
      FullHotel(
        id: '1',
        name: 'The Horizon Retreat',
        location: 'Los Angeles, CA',
        pricePerNight: 480,
        rating: 4.5,
        imageUrl: 'https://images.unsplash.com/photo-1602002418082-a4443e081dd1',
        bed: '3 bed',
        bath: '3 bathroom',
        isPopular: true,
        isFavorite: true,
        amenities: ['WiFi', 'Pool', 'Restaurant', 'Spa'],
        description: 'Beautiful retreat with mountain views and traditional architecture',
      ),
      FullHotel(
        id: '2',
        name: 'Opal Grove Inn',
        location: 'San Diego, CA',
        pricePerNight: 190,
        rating: 4.5,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        bed: '2 bed',
        bath: '2 bathroom',
        isPopular: true,
        isFavorite: true,
        amenities: ['WiFi', 'Beach Access', 'Restaurant'],
        description: 'Tropical paradise with palm trees and ocean breeze',
      ),
      FullHotel(
        id: '3',
        name: 'Sunset Paradise Resort',
        location: 'Miami, FL',
        pricePerNight: 350,
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
        bed: '3 bed',
        bath: '2 bathroom',
        isPopular: true,
        isFavorite: false,
        amenities: ['WiFi', 'Pool', 'Gym', 'Bar'],
        description: 'Luxury resort with stunning sunset views',
      ),
      FullHotel(
        id: '4',
        name: 'Mountain View Lodge',
        location: 'Denver, CO',
        pricePerNight: 280,
        rating: 4.7,
        imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4',
        bed: '2 bed',
        bath: '2 bathroom',
        isPopular: true,
        isFavorite: false,
        amenities: ['WiFi', 'Fireplace', 'Restaurant', 'Hiking'],
        description: 'Cozy lodge with breathtaking mountain scenery',
      ),
      FullHotel(
        id: '5',
        name: 'Beach House Villa',
        location: 'Malibu, CA',
        pricePerNight: 550,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
        bed: '4 bed',
        bath: '4 bathroom',
        isPopular: true,
        isFavorite: true,
        amenities: ['WiFi', 'Private Beach', 'Pool', 'Chef'],
        description: 'Exclusive beachfront villa with private amenities',
      ),
    ];
  }

  static List<FullHotel> getAllHotels() {
    return getMostPopularHotels();
  }

  static FullHotel? getHotelById(String id) {
    try {
      return getMostPopularHotels().firstWhere((hotel) => hotel.id == id);
    } catch (e) {
      return null;
    }
  }


  static List<FullHotel> getRecommendedHotels() {
    return getMostPopularHotels().take(3).toList();
  }

  static List<FullHotel> getNearbyHotels() {
    return getMostPopularHotels().take(2).toList();
  }

  static List<FullHotel> getBestTodayHotels() {
    return getMostPopularHotels().take(2).toList();
  }
}