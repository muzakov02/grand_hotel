// search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/features/home/widgets/recomended/property_type_filter.dart';
import 'package:grand_hotel/features/search/widgets/search_hotels_list.dart';
import 'package:grand_hotel/bloc/search_hotel/search_hotels_bloc.dart';
import 'package:grand_hotel/bloc/search_hotel/search_hotels_event.dart';

import 'filter/filter_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // 👇 BU YERGA QO'SHING
  @override
  void initState() {
    super.initState();
    // Search screen ochilganda filterlarni reset qilish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchHotelsBloc>().add(ResetSearchFilters());
    });
  }

  // 👇 Bu ham qo'shing (controller tozalash uchun)
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Search',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // Notification action
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController, // 👈 Controller qo'shing
                onChanged: (value) {
                  context.read<SearchHotelsBloc>().add(
                    FilterSearchHotels(searchQuery: value),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 0.9,
                            minChildSize: 0.5,
                            maxChildSize: 0.95,
                            builder: (_, controller) => FilterBottomSheet(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            const PropertyTypeFilter(),
            SizedBox(height: 20),
            Expanded(
              child: const SearchHotelsList(),
            ),
          ],
        ),
      ),
      // 👇 IXTIYORIY: Tez reset qilish uchun FAB
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.white,
        onPressed: () {
          _searchController.clear();
          context.read<SearchHotelsBloc>().add(ResetSearchFilters());
        },
        child: Icon(Icons.clear_all, color: Colors.black87),
      ),
    );
  }
}