import 'package:grand_hotel/models/property.dart';

class Booking {
  final String id;
  final Property property;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;
  final String roomType;
  final String phoneNumber;
  final double totalPrice;
  final String paymentMethod;
  final DateTime bookingDate;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.property,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
    required this.roomType,
    required this.phoneNumber,
    required this.totalPrice,
    required this.paymentMethod,
    required this.bookingDate,
    this.status = BookingStatus.booked,
  });

  Booking copyWith({
    String? id,
    Property? property,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? guests,
    String? roomType,
    String? phoneNumber,
    double? totalPrice,
    String? paymentMethod,
    DateTime? bookingDate,
    BookingStatus? status,
  }) {
    return Booking(
      id: id ?? this.id,
      property: property ?? this.property,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      guests: guests ?? this.guests,
      roomType: roomType ?? this.roomType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      bookingDate: bookingDate ?? this.bookingDate,
      status: status ?? this.status,
    );
  }
}

enum BookingStatus {
  booked,
  cancelled,
  completed,
}