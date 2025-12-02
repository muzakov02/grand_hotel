import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/booking_model.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingState()) {
    on<AddBooking>(_onAddBooking);
    on<LoadBookings>(_onLoadBookings);
    on<CancelBooking>(_onCancelBooking);
  }

  void _onAddBooking(
      AddBooking event,
      Emitter<BookingState> emit,
      ) {
    final updatedBookings = List<Booking>.from(state.bookings)
      ..insert(0, event.booking); // Yangi booking birinchi o'rinda

    emit(state.copyWith(bookings: updatedBookings));
  }

  void _onLoadBookings(
      LoadBookings event,
      Emitter<BookingState> emit,
      ) {
    // Bu yerda API dan yoki local storage dan bookinglar yuklanadi
    emit(state.copyWith(isLoading: false));
  }

  void _onCancelBooking(
      CancelBooking event,
      Emitter<BookingState> emit,
      ) {
    final updatedBookings = state.bookings.map((booking) {
      if (booking.id == event.bookingId) {
        return booking.copyWith(status: BookingStatus.cancelled);
      }
      return booking;
    }).toList();

    emit(state.copyWith(bookings: updatedBookings));
  }
}