// filter_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'filter_option_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isNewNotificationSelected = false;
  bool isByChatSelected = false;
  bool isLongestSelected = false;
  bool isDiscountsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Material widget qo'shildi
      color: const Color(0xFFF6F6F6),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Drag indicator
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Filter By',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            // Scrollable options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    FilterOptionWidget(
                      title: 'New Notification',
                      isSelected: isNewNotificationSelected,
                      onTap: () {
                        setState(() {
                          isNewNotificationSelected = !isNewNotificationSelected;
                        });
                      },
                    ),
                    FilterOptionWidget(
                      title: 'By Chat',
                      isSelected: isByChatSelected,
                      onTap: () {
                        setState(() {
                          isByChatSelected = !isByChatSelected;
                        });
                      },
                    ),
                    FilterOptionWidget(
                      title: 'Longest',
                      isSelected: isLongestSelected,
                      onTap: () {
                        setState(() {
                          isLongestSelected = !isLongestSelected;
                        });
                      },
                    ),
                    FilterOptionWidget(
                      title: 'Discounts',
                      isSelected: isDiscountsSelected,
                      onTap: () {
                        setState(() {
                          isDiscountsSelected = !isDiscountsSelected;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Apply button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2853AF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}