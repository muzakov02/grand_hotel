part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookings extends BookingEvent {}

class AddBooking extends BookingEvent {
  final Booking booking;

  const AddBooking(this.booking);

  @override
  List<Object?> get props => [booking];
}

class CancelBooking extends BookingEvent {
  final String bookingId;

  const CancelBooking(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}