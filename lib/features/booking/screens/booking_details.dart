import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../models/booking_model.dart';

class BookingDetails extends StatefulWidget {
  final Booking booking;

  const BookingDetails({super.key, required this.booking});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  String formatDateRange(DateTime checkIn, DateTime checkOut) {
    return '${checkIn.day} - ${checkOut.day} ${DateFormat('MMM yyyy').format(checkOut)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Booking Detail',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Icon(Icons.more_vert),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Hotel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          child: Image.network(
                            widget.booking.property.imageUrl,
                            width: 78,
                            height: 78,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nom va rating
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.booking.property.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // SizedBox(width: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 18),
                                        SizedBox(width: 4),
                                        Text(
                                          '${widget.booking.property.rating}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 4),

                                // Location
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/location.svg'),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        widget.booking.property.location,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 6),

                                // Narx
                                Row(
                                  children: [
                                    Text(
                                      '\$${widget.booking.totalPrice.round()}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2853AF),
                                      ),
                                    ),
                                    Text(
                                      ' /night',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Map Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF78828A),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Open Map',
                            style: TextStyle(
                              color: Color(0xFF2853AF),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Map placeholder
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.map,
                          size: 50,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    Text(
                      'Your Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF78828A),
                      ),
                    ),
                    SizedBox(height: 12),

                    _buildInfoRow(
                      'assets/icons/calendar2.svg',
                      'Dates',
                      formatDateRange(widget.booking.checkInDate,
                          widget.booking.checkOutDate),
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      'assets/icons/user2.svg',
                      'Guest',
                      '${widget.booking.guests} Guests (1 Room)',
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      'assets/icons/building.svg',
                      'Room type',
                      widget.booking.roomType,
                    ),
                    SizedBox(height: 12),
                    _buildInfoRow(
                      'assets/icons/call.svg',
                      'Phone',
                      widget.booking.phoneNumber,
                    ),
                    SizedBox(height: 40),

                    Center(
                      child: BarcodeWidget(
                        barcode: Barcode.code128(),
                        // Code128 barcode turi
                        data: widget.booking.id ?? '06158310-5427-471d-bd9029b',
                        width: 280,
                        height: 80,
                        drawText: true,
                        // Barcode ostida matn
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    SizedBox(height: 16),

                    // Guest
                  ]),
            ),
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

  String _generateBookingQRData() {
    // Barcha booking ma'lumotlarini QR kodga kiritamiz
    return '''
Booking ID: ${widget.booking.id ?? 'N/A'}
Hotel: ${widget.booking.property.name}
Location: ${widget.booking.property.location}
Check-in: ${DateFormat('dd MMM yyyy').format(widget.booking.checkInDate)}
Check-out: ${DateFormat('dd MMM yyyy').format(widget.booking.checkOutDate)}
Guests: ${widget.booking.guests} Guests (1 Room)
Room Type: ${widget.booking.roomType}
Phone: ${widget.booking.phoneNumber}
Total Price: \$${widget.booking.totalPrice.round()}
Rating: ${widget.booking.property.rating}
'''
        .trim();
  }
}
