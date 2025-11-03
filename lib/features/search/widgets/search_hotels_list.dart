import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/features/search/widgets/search_hotel_card.dart';

import '../../../bloc/search_hotel/search_hotels_bloc.dart';
import '../../../bloc/search_hotel/search_hotels_state.dart';

class SearchHotelsList extends StatelessWidget {
  const SearchHotelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchHotelsBloc, SearchHotelsState>(
      builder: (context, state) {
        if (state is SearchHotelsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SearchHotelsError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is SearchHotelsLoaded) {
          if (state.filteredHotels.isEmpty) {
            return Center(
              child: Text(
                'Mehmonxona topilmadi',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.filteredHotels.length,
            itemBuilder: (context, index) {
              return SearchHotelCard(
                hotel: state.filteredHotels[index],
              );
            },
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}