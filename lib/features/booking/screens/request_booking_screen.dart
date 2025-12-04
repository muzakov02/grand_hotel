
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grand_hotel/features/booking/screens/checkout_screen.dart';
import 'package:intl/intl.dart';
import '../../../models/property.dart';

class RequestBookingScreen extends StatefulWidget {
  final String hotelId;
  final String hotelName;
  final double hotelPrice;
  final String hotelImage;
  final Property property;

  const RequestBookingScreen({
    super.key,
    required this.hotelId,
    required this.hotelName,
    required this.hotelPrice,
    required this.hotelImage,
    required this.property,
  });

  @override
  _RequestBookingScreenState createState() => _RequestBookingScreenState();
}

class _RequestBookingScreenState extends State<RequestBookingScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests = 1;
  String roomType = 'Queen Room';
  String phoneNumber = '+998 90 123 45 67';
  double cleaningFee = 5;
  double serviceFee = 5;

  String formatDate(DateTime? date) {
    if (date == null) return 'Choose Date';
    return DateFormat('MMM dd, yyyy').format(date);
  }


  String formatDateRange() {
    if (checkInDate == null || checkOutDate == null) {
      return 'Not selected';
    }
    final format = DateFormat('MMM dd');
    return '${format.format(checkInDate!)} - ${format.format(checkOutDate!)}';
  }

  int calculateNights() {
    if (checkInDate == null || checkOutDate == null) return 0;
    return checkOutDate!.difference(checkInDate!).inDays;
  }

  double calculateTotal() {
    int nights = calculateNights();
    if (nights == 0) return 0;
    double guestMultiplier = guests > 1 ? 1 + ((guests - 1) * 0.25) : 1;
    return (widget.hotelPrice * nights * guestMultiplier) +
        cleaningFee +
        serviceFee;
  }

  double calculateSubtotal() {
    int nights = calculateNights();
    if (nights == 0) return 0;
    double guestMultiplier = guests > 1 ? 1 + ((guests - 1) * 0.25) : 1;
    return widget.hotelPrice * nights * guestMultiplier;
  }

  Future<void> selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkInDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        checkInDate = picked;
        checkOutDate = null;
      });
    }
  }

  Future<void> selectCheckOutDate(BuildContext context) async {
    if (checkInDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Iltimos, avval Check-In sanasini tanlang!')),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkInDate!.add(Duration(days: 1)),
      firstDate: checkInDate!.add(Duration(days: 1)),
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        checkOutDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Request to book',
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
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Section
              Text(
                'Date',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectCheckInDate(context),
                      child: Container(
                        height: 94,
                        width: 158,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF66707A).withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Check - In',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              formatDate(checkInDate),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectCheckOutDate(context),
                      child: Container(
                        height: 94,
                        width: 158,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF66707A).withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Check - Out',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              formatDate(checkOutDate),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Guest Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Guest',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (guests > 1) {
                            setState(() {
                              guests--;
                            });
                          }
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFECF1F6),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '−',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF2853AF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        '$guests',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            guests++;
                          });
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFF2853AF),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Payment Method
              Text(
                'Pay With',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Center(
                child: Container(
                  height: 64,
                  width: 327,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/card.svg',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FastPayz',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '••••4587',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFF2853AF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Edit',
                          style:
                          TextStyle(fontSize: 12, color: Color(0xFF2853AF)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Payment Details
              Text(
                'Payment Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Column(
                children: [
                  _buildPaymentRow(
                    'Total: ${calculateNights()} Night × $guests guests',
                    '\$${calculateSubtotal().round()}',
                  ),
                  SizedBox(height: 12),
                  _buildPaymentRow(
                    'Cleaning Fee',
                    '\$${cleaningFee.round()}',
                  ),
                  SizedBox(height: 12),
                  _buildPaymentRow(
                    'Service Fee',
                    '\$${serviceFee.round()}',
                  ),
                  Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payment:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${calculateTotal().round()}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          // color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withValues(alpha: 0.05),
          //     blurRadius: 10,
          //     offset: Offset(0, -5),
          //   ),
          // ],
        ),
        child: SafeArea(
          child:  ElevatedButton(
            onPressed: (checkInDate != null && checkOutDate != null)
                ? () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(
                    property: widget.property,
                    checkInDate: checkInDate!,
                    checkOutDate: checkOutDate!,
                    guests: guests,
                    roomType: roomType,
                    phoneNumber: phoneNumber,
                    subtotal: calculateSubtotal(),
                    cleaningFee: cleaningFee,
                    serviceFee: serviceFee,
                    totalPrice: calculateTotal(),
                  ),
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2853AF),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Checkout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}