import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grand_hotel/models/property.dart';
import 'package:grand_hotel/bloc/recommended/recommended_bloc.dart';
import 'package:grand_hotel/bloc/recommended/recommended_event.dart';
import 'package:grand_hotel/bloc/recommended/recommended_state.dart';

class PropertyTypeFilter extends StatelessWidget {
  const PropertyTypeFilter({super.key});

  // SVG icon yo'llari
  static const String _iconsPath = 'assets/icons';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedBloc, RecommendedState>(
      builder: (context, state) {
        PropertyType selectedType = PropertyType.all;

        if (state is RecommendedLoaded) {
          selectedType = state.selectedType;
        }

        return SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildFilterChip(
                context,
                label: 'All',
                iconPath: null,
                type: PropertyType.all,
                isSelected: selectedType == PropertyType.all,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                label: 'Villas',
                iconPath: '$_iconsPath/villa.svg',
                type: PropertyType.villas,
                isSelected: selectedType == PropertyType.villas,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                label: 'Hotels',
                iconPath: '$_iconsPath/hotel.svg',
                type: PropertyType.hotels,
                isSelected: selectedType == PropertyType.hotels,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                label: 'Apartments',
                iconPath: '$_iconsPath/apartment.svg',
                type: PropertyType.apartments,
                isSelected: selectedType == PropertyType.apartments,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
      BuildContext context, {
        required String label,
        required String? iconPath, // Nullable
        required PropertyType type,
        required bool isSelected,
      }) {
    return GestureDetector(
      onTap: () {
        context.read<RecommendedBloc>().add(FilterPropertiesByType(type));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SVG Icon - faqat iconPath mavjud bo'lsa
            if (iconPath != null) ...[
              SvgPicture.asset(
                iconPath,
                width: 28,
                height: 28,
                colorFilter: isSelected
                    ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                    : null, // 👈 null bo‘lsa, SVG asl rangda chiqadi
              ),
              const SizedBox(width: 8),
            ],


            // Text
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}