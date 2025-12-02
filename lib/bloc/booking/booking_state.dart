part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final List<Booking> bookings;
  final bool isLoading;

  const BookingState({
    this.bookings = const [],
    this.isLoading = false,
  });

  BookingState copyWith({
    List<Booking>? bookings,
    bool? isLoading,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // Faqat booked statusdagi bookinglar
  List<Booking> get activeBookings => bookings
      .where((booking) => booking.status == BookingStatus.booked)
      .toList();

  // Cancelled yoki completed bookinglar
  List<Booking> get historyBookings => bookings
      .where((booking) => booking.status != BookingStatus.booked)
      .toList();

  @override
  List<Object?> get props => [bookings, isLoading];
}