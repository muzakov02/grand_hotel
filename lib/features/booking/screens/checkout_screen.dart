import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grand_hotel/features/booking/widgets/payment_bottom_sheet.dart';
import 'package:grand_hotel/features/home/widgets/recomended/property_card.dart';
import 'package:grand_hotel/models/property.dart';
import 'package:intl/intl.dart';

import '../../../bloc/booking/booking_bloc.dart';
import '../../../bloc/payment/payment_method_bloc.dart';
import '../../../models/booking_model.dart';
import '../../../models/cupon.dart';
import '../widgets/cupon_bottom_sheet.dart';

class CheckoutScreen extends StatefulWidget {
  final Property property;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;
  final String roomType;
  final String phoneNumber;
  final double subtotal;
  final double cleaningFee;
  final double serviceFee;
  final double totalPrice;

  const CheckoutScreen({
    super.key,
    required this.property,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
    required this.roomType,
    required this.phoneNumber,
    required this.subtotal,
    required this.cleaningFee,
    required this.serviceFee,
    required this.totalPrice,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Coupon? selectedCoupon;

  String formatDateRange() {
    final format = DateFormat('MMM dd');
    return '${format.format(widget.checkInDate)} - ${format.format(widget.checkOutDate)}';
  }

  void _showCouponBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CouponBottomSheet(
        selectedCoupon: selectedCoupon,
        onCouponSelected: (coupon) {
          setState(() {
            selectedCoupon = coupon;
          });
        },
      ),
    );
  }

  void _showPaymentBottomSheet() {
    final bookingData = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      property: widget.property,
      checkInDate: widget.checkInDate,
      checkOutDate: widget.checkOutDate,
      guests: widget.guests,
      roomType: widget.roomType,
      phoneNumber: widget.phoneNumber,
      totalPrice: widget.totalPrice,
      paymentMethod: '',
      bookingDate: DateTime.now(),
      status: BookingStatus.booked,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<PaymentMethodBloc>()),
          BlocProvider.value(value: context.read<BookingBloc>()),
        ],
        child: PaymentBottomSheet(
          bookingData: bookingData,
          onPaymentMethodSelected: (method) {
            print('Selected payment: ${method.name}');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Checkout',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PropertyCard(property: widget.property, onTap: () {}),
              SizedBox(height: 20),

              // Your Booking Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Booking',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF2853AF),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      'assets/icons/calendar2.svg',
                      'Dates',
                      formatDateRange(),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      'assets/icons/user2.svg',
                      'Guest',
                      '${widget.guests} Guests (1 Room)',
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      'assets/icons/building.svg',
                      'Room type',
                      widget.roomType,
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      'assets/icons/call.svg',
                      'Phone',
                      widget.phoneNumber,
                    ),

                    SizedBox(height: 24),

                    CustomPaint(
                      painter: DashedLinePainter(),
                      child: Container(height: 1),
                    ),

                    SizedBox(height: 16),

                    // Price Details
                    Text(
                      'Price Details',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF2853AF),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 12),
                    _buildPriceRow('Price', '\$${widget.subtotal.round()}'),
                    SizedBox(height: 8),
                    _buildPriceRow(
                        'Admin fee', '\$${widget.cleaningFee.round()}'),
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total price',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(
                          '\$${widget.totalPrice.round()}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF171725)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Promo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),

              // Promo Section
              InkWell(
                onTap: _showCouponBottomSheet,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFECF1F6),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/promo.svg'),
                          SizedBox(width: 12),
                          Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2853AF),
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right,
                          size: 24, color: Color(0xFF2853AF)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),

              BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                builder: (context, state) {
                  if (state.selectedPaymentMethod != null) {
                    return InkWell(
                      onTap: _showPaymentBottomSheet,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:
                                      state.selectedPaymentMethod!.iconPath !=
                                              null
                                          ? SvgPicture.asset(
                                              state.selectedPaymentMethod!
                                                  .iconPath!,
                                              fit: BoxFit.contain,
                                            )
                                          : Icon(Icons.payment,
                                              color: Color(0xFF2853AF)),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.selectedPaymentMethod!.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (state.selectedPaymentMethod!
                                            .cardNumber !=
                                        null)
                                      Text(
                                        state
                                            .selectedPaymentMethod!.cardNumber!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(Icons.chevron_right,
                                size: 24, color: Color(0xFF2853AF)),
                          ],
                        ),
                      ),
                    );
                  }

                  return InkWell(
                    onTap: _showPaymentBottomSheet,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFECF1F6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.payment, color: Color(0xFF2853AF)),
                              SizedBox(width: 12),
                              Text(
                                'Select Payment Method',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF2853AF),
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right,
                              size: 24, color: Color(0xFF2853AF)),
                        ],
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.selectedPaymentMethod != null
                    ? () {
                        print(
                            'Processing payment with ${state.selectedPaymentMethod!.name}');
                      }
                    : _showPaymentBottomSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2853AF),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  state.selectedPaymentMethod != null
                      ? 'Continue to Payment'
                      : 'Select Payment',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(iconPath, width: 20, height: 20),
            SizedBox(width: 8),
            Text(label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
        Text(value, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Color(0xFF171725))),
        Text(value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
