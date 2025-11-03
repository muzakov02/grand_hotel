import '../models/facilities.dart';

class FacilitiesData {
  static List<Facilities> getAllFacilities() {
    return [
      Facilities(
        id: '1',
        name: 'Food and Drink',
        iconPath: 'assets/icons/food.svg',
        facilities: [
          'A la carte dinner',
          'A la carte lunch',
          'Breakfast',
          'Vegetarian meal',
        ],
      ),
      Facilities(
        id: '2',
        name: 'Transportation',
        iconPath: 'assets/icons/car.svg',
        facilities: [
          'Airport shuttle',
          'Car rental',
          'Parking',
          'Taxi service',
          'Valet parking',
        ],
      ),
      Facilities(
        id: '3',
        name: 'General',
        iconPath: 'assets/icons/setting.svg',
        facilities: [
          '24-hour front desk',
          'Air conditioning',
          'Heating',
          'Non-smoking rooms',
        ],
      ),
      Facilities(
        id: '4',
        name: 'Hotel Service',
        iconPath: 'assets/icons/hotel_service.svg',
        facilities: [
          'Concierge service',
          'Room service',
        ],
      ),
      Facilities(
        id: '5',
        name: 'Business Facilities',
        iconPath: 'assets/icons/business.svg',
        facilities: [
          'Business center',
          'Fax/photocopying',
          'Meeting rooms',
          'Conference hall',
          'Projector',
          'Video conferencing',
        ],
      ),
      Facilities(
        id: '6',
        name: 'Nearby facilities',
        iconPath: 'assets/icons/hospital.svg',
        facilities: [
          'Beach',
          'Shopping mall',
          'Restaurant',
          'Park',
          'Museum',
          'Theater',
          'Airport',
          'Train station',
        ],
      ),
      Facilities(
        id: '7',
        name: 'Kids',
        iconPath: 'assets/icons/cake.svg',
        facilities: [
          'Kids pool',
          'Playground',
          'Babysitting',
        ],
      ),
      Facilities(
        id: '8',
        name: 'Connectivity',
        iconPath: 'assets/icons/wifi.svg',
        facilities: [
          'Free WiFi',
          'WiFi in all areas',
        ],
      ),
      Facilities(
        id: '9',
        name: 'Public Facilities',
        iconPath: 'assets/icons/public.svg',
        facilities: [
          'Garden',
          'Terrace',
          'Sun deck',
          'BBQ facilities',
          'Picnic area',
          'Outdoor furniture',
          'Outdoor dining area',
          'Library',
          'Games room',
          'TV lounge',
          'Fireplace',
          'Chapel/shrine',
          'Shared lounge',
          'Bridal suite',
          'Soundproof rooms',
          'Designated smoking area',
        ],
      ),
    ];
  }

  static List<Facilities> getFacilitiesByHotel(String hotelId) {
    return getAllFacilities();
  }
}