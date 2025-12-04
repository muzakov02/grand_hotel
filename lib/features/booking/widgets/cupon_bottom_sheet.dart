import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/cupon.dart';

class CouponBottomSheet extends StatefulWidget {
  final Coupon? selectedCoupon;
  final Function(Coupon) onCouponSelected;

  const CouponBottomSheet({
    super.key,
    required this.selectedCoupon,
    required this.onCouponSelected,
  });

  @override
  State<CouponBottomSheet> createState() => _CouponBottomSheetState();
}

class _CouponBottomSheetState extends State<CouponBottomSheet> {
  Coupon? _tempSelectedCoupon;

  @override
  void initState() {
    super.initState();
    _tempSelectedCoupon = widget.selectedCoupon;
  }

  @override
  Widget build(BuildContext context) {
    final coupons = [
      Coupon(
        id: '1',
        title: '20% Cashback',
        description: 'Valid till 31 Dec. See Detail',
        discount: '20% Cashback',
        validUntil: '31 Dec',
      ),
      Coupon(
        id: '2',
        title: '15% Discount',
        description: 'Valid till 15 Mar. See Detail',
        discount: '15% Discount',
        validUntil: '15 Mar',
      ),
      Coupon(
        id: '3',
        title: '20% Cashback',
        description: 'Valid till 20 Apr. See Detail',
        discount: '20% Cashback',
        validUntil: '20 Apr',
      ),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      // ),
      child: Column(
        children: [
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
                  'My Coupon',
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
              itemCount: coupons.length,
              itemBuilder: (context, index) {
                final coupon = coupons[index];
                final isSelected = _tempSelectedCoupon?.id == coupon.id;

                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Color(0xFF2853AF)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/promo.svg',
                      height: 24,
                      width: 24,
                    ),
                    title: Text(
                      coupon.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Color(0xFF2853AF) : Colors.black,
                      ),
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        children: [
                          TextSpan(text: 'Valid till ${coupon.validUntil}. '),
                          TextSpan(
                            text: 'See Detail',
                            style: TextStyle(
                              color: Color(0xFF2853AF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check, color: Color(0xFF2853AF))
                        : null,
                    onTap: () {
                      setState(() {
                        _tempSelectedCoupon = coupon;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Use Coupon Button
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _tempSelectedCoupon != null
                      ? () {
                    widget.onCouponSelected(_tempSelectedCoupon!);
                    Navigator.pop(context);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2853AF),
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Use Coupon',
                    style: TextStyle(
                      fontSize: 16,
                      color: _tempSelectedCoupon != null
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
  }
}