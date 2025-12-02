// data/property_data.dart
import '../models/property.dart';

class PropertyData {
  static List<Property> getRecommendedProperties() {
    return [
      Property(
         '1',
        name: 'Serenity Sands',
        location: 'Honolulu, HI',
        pricePerNight: 270,
        rating: 4.0,
        imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
        type: PropertyType.hotels,
        isRecommended: true, id: '',
      ),
      Property(
        '2',
        name: 'Ocean Breeze Villa',
        location: 'Miami, FL',
        pricePerNight: 450,
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
        type: PropertyType.villas,
        isRecommended: true, id: '',
      ),
      Property(
         '3',
        name: 'Mountain View Resort',
        location: 'Aspen, CO',
        pricePerNight: 380,
        rating: 4.6,
        imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4',
        type: PropertyType.hotels,
        isRecommended: true, id: '',
      ),
      Property(
         '4',
        name: 'Urban Luxury Apartment',
        location: 'New York, NY',
        pricePerNight: 320,
        rating: 4.5,
        imageUrl: 'https://images.unsplash.com/photo-1502672260066-6bc35f0a540d',
        type: PropertyType.apartments,
        isRecommended: true, id: '',
      ),
      Property(
         '5',
        name: 'Tropical Paradise Villa',
        location: 'Bali, Indonesia',
        pricePerNight: 520,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        type: PropertyType.villas,
        isRecommended: true, id: '',
      ),
    ];
  }

  static List<Property> getPropertiesByType(PropertyType type) {
    if (type == PropertyType.all) {
      return getRecommendedProperties();
    }
    return getRecommendedProperties()
        .where((property) => property.type == type)
        .toList();
  }
}