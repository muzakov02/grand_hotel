import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grand_hotel/features/booking/screens/booking_complete_screen.dart';
import 'package:grand_hotel/features/booking/screens/new_card_screen.dart';
import '../../../bloc/booking/booking_bloc.dart';
import '../../../bloc/payment/payment_method_bloc.dart';
import '../../../models/booking_model.dart';
import '../../../models/payment_method.dart';

class PaymentBottomSheet extends StatefulWidget {
  final Function(PaymentMethod) onPaymentMethodSelected;
  final Booking? bookingData;

  const PaymentBottomSheet({
    super.key,
    required this.onPaymentMethodSelected,
    this.bookingData,
  });

  @override
  State<PaymentBottomSheet> createState() => _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentBottomSheet> {
  PaymentMethod? _tempSelectedPayment;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final currentState = context.read<PaymentMethodBloc>().state;
    _tempSelectedPayment = currentState.selectedPaymentMethod;
  }

  Future<void> _navigateToAddCard() async {
    final result = await Navigator.push<PaymentMethod>(
      context,
      MaterialPageRoute(
        builder: (context) => NewCardScreen(),
      ),
    );

    if (result != null && mounted) {
      context.read<PaymentMethodBloc>().add(AddPaymentMethod(result));
      setState(() {
        _tempSelectedPayment = result;
      });
    }
  }

  Future<void> _confirmPayment() async {
    if (_tempSelectedPayment != null && widget.bookingData != null) {
      setState(() {
        _isProcessing = true;
      });

      // Payment method ni saqlash
      context
          .read<PaymentMethodBloc>()
          .add(SelectPaymentMethod(_tempSelectedPayment!));

      // Booking yaratish
      final booking = widget.bookingData!.copyWith(
        paymentMethod: _tempSelectedPayment!.name,
      );

      context.read<BookingBloc>().add(AddBooking(booking));

      widget.onPaymentMethodSelected(_tempSelectedPayment!);

      // Biroz kutish (animation uchun)
      await Future.delayed(Duration(milliseconds: 300));

      if (mounted) {
        // Bottom sheet ni yopish
        Navigator.pop(context);

        // Booking Complete Screen ga o'tish
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingCompleteScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag indicator
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: state.paymentMethods.length + 1,
                  itemBuilder: (context, index) {
                    // Oxirgi item - Add Debit Card
                    if (index == state.paymentMethods.length) {
                      return InkWell(
                        onTap: _navigateToAddCard,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2853AF),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Add Debit Card',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final method = state.paymentMethods[index];
                    final isSelected = _tempSelectedPayment?.id == method.id;

                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: method.iconPath != null
                              ? SvgPicture.asset(
                            method.iconPath!,
                            fit: BoxFit.contain,
                          )
                              : Icon(Icons.payment, color: Color(0xFF2853AF)),
                        ),
                        title: Text(
                          method.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: method.cardNumber != null
                            ? Text(
                          method.cardNumber!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        )
                            : null,
                        trailing: isSelected
                            ? Icon(Icons.check_box, color: Color(0xFF2853AF))
                            : Icon(Icons.check_box_outline_blank,
                            color: Colors.grey),
                        onTap: () {
                          setState(() {
                            _tempSelectedPayment = method;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              // Confirm Button
              Container(
                padding: EdgeInsets.all(16),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isProcessing || _tempSelectedPayment == null
                          ? null
                          : _confirmPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2853AF),
                        disabledBackgroundColor: Colors.grey.shade300,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isProcessing
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : Text(
                        'Confirm and Pay',
                        style: TextStyle(
                          fontSize: 16,
                          color: _tempSelectedPayment != null
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}