// widgets/filter_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/search_hotel/search_hotels_bloc.dart';
import 'package:grand_hotel/bloc/search_hotel/search_hotels_event.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int adults = 2;
  int children = 1;
  RangeValues priceRange = RangeValues(0, 500);
  bool instantBook = false;
  String selectedLocation = '';
  Set<String> selectedFacilities = {};
  int? selectedRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Filter By',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Guests'),
                  SizedBox(height: 8),
                  _buildGuestSelector(),
                  SizedBox(height: 24),

                  _buildSectionTitle('Price'),
                  SizedBox(height: 8),
                  _buildPriceSlider(),
                  SizedBox(height: 24),

                  _buildInstantBook(),
                  SizedBox(height: 24),

                  _buildSectionTitle('Location'),
                  SizedBox(height: 12),
                  _buildLocationChips(),
                  SizedBox(height: 24),

                  _buildSectionTitle('Facilities'),
                  SizedBox(height: 12),
                  _buildFacilitiesList(),
                  SizedBox(height: 24),

                  _buildSectionTitle('Ratings'),
                  SizedBox(height: 12),
                  _buildRatingChips(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Only Apply Button (Reset removed)
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _applyFilter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2F5FD7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Apply Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildGuestSelector() {
    return GestureDetector(
      onTap: _showGuestPicker,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${adults + children} Guest ($adults Adult, $children Children)',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showGuestPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.all(20),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    'Select Guests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),

                  _buildGuestCounter(
                    'Adults',
                    adults,
                        (value) {
                      setModalState(() {
                        adults = value;
                      });
                      setState(() {
                        adults = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),

                  _buildGuestCounter(
                    'Children',
                    children,
                        (value) {
                      setModalState(() {
                        children = value;
                      });
                      setState(() {
                        children = value;
                      });
                    },
                  ),
                  SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2F5FD7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGuestCounter(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.remove, size: 18),
                onPressed: value > 0 ? () => onChanged(value - 1) : null,
                color: value > 0 ? Colors.black87 : Colors.grey.shade400,
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                '$value',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(0xFF2F5FD7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.add, size: 18, color: Colors.white),
                onPressed: value < 10 ? () => onChanged(value + 1) : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '\$${priceRange.start.toInt()}-\$${priceRange.end.toInt()}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: priceRange,
          min: 0,
          max: 500,
          divisions: 50,
          activeColor: Color(0xFF2F5FD7),
          inactiveColor: Colors.grey.shade300,
          onChanged: (values) {
            setState(() {
              priceRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildInstantBook() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instant Book',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Book without waiting for the host to respond',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        Switch(
          value: instantBook,
          onChanged: (value) {
            setState(() {
              instantBook = value;
            });
          },
          activeThumbColor: Color(0xFF2F5FD7),
        ),
      ],
    );
  }

  Widget _buildLocationChips() {
    // “All” olib tashlandi
    final locations = ['San Diego', 'New York', 'Amsterdam'];
    return Wrap(
      spacing: 8,
      children: locations.map((location) {
        final isSelected = selectedLocation == location;
        return ChoiceChip(
          label: Text(location),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedLocation = location;
            });
          },
          backgroundColor: Colors.grey.shade100,
          selectedColor: Color(0xFF2F5FD7),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
      }).toList(),
    );
  }

  Widget _buildFacilitiesList() {
    final facilities = ['Free Wifi', 'Swimming Pool', 'Tv', 'Laundry'];
    return Column(
      children: facilities.map((facility) {
        final isSelected = selectedFacilities.contains(facility);
        return CheckboxListTile(
          title: Text(
            facility,
            style: TextStyle(fontSize: 14),
          ),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                selectedFacilities.add(facility);
              } else {
                selectedFacilities.remove(facility);
              }
            });
          },
          activeColor: Color(0xFF2F5FD7),
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }

  Widget _buildRatingChips() {
    return Wrap(
      children: List.generate(5, (index) {
        final rating = 5 - index;
        final isSelected = selectedRating == rating;
        return Padding(
          padding: EdgeInsets.only(right: 6),
          child: ChoiceChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: isSelected ? Colors.white : Colors.amber,
                ),
                SizedBox(width: 4),
                Text('$rating'),
              ],
            ),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                selectedRating = selected ? rating : null;
              });
            },
            backgroundColor: Colors.grey.shade100,
            selectedColor: Color(0xFF2F5FD7),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        );
      }),
    );
  }

  void _applyFilter() {
    context.read<SearchHotelsBloc>().add(
      FilterSearchHotels(
        minPrice: priceRange.start,
        maxPrice: priceRange.end,
        minRating: selectedRating?.toDouble(),
        location: selectedLocation.isNotEmpty ? selectedLocation : null,
        facilities: selectedFacilities.isNotEmpty ? selectedFacilities.toList() : null,
        instantBook: instantBook,
        adults: adults,
        children: children,
      ),
    );
    Navigator.pop(context);
  }
}
