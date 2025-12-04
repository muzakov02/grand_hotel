import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grand_hotel/features/profile/screens/personal_info_screen.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;
  final Function(Map<String, String>) onProfileUpdated;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.onProfileUpdated,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: imageUrl != null
              ? NetworkImage(imageUrl!)
              : const AssetImage('assets/images/profile2.png') as ImageProvider,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            final nameParts = name.split(' ');
            final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
            final lastName =
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

            final result = await Navigator.push<Map<String, String>>(
              context,
              MaterialPageRoute(
                builder: (context) => PersonalInfoScreen(
                  initialFirstName: firstName,
                  initialLastName: lastName,
                  initialEmail: email,
                ),
              ),
            );

            if (result != null) {
              onProfileUpdated(result);
            }
          },
          icon: SvgPicture.asset(
            'assets/icons/edit.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
