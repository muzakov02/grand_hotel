import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Legal and Policies',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RawScrollbar(
          // Custom scrollbar uchun
          thumbColor: const Color(0xFF2853AF), // Ko'k rang
          thickness: 8.0, // Qalinroq
          radius: const Radius.circular(10),
          thumbVisibility: true, // Har doim ko'rinadi
          trackVisibility: false,
          trackColor: Colors.grey.shade200, // Track rangi (agar kerak bo'lsa)
          trackBorderColor: Colors.transparent,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 12), // Scrollbar uchun joy
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Terms bo'limi
                _buildSection(
                  title: 'Terms',
                  content: _getLoremIpsum(),
                ),
                const SizedBox(height: 24),

                // Changes to the Service bo'limi
                _buildSection(
                  title: 'Changes to the Service and/or Terms:',
                  content: _getLoremIpsum(),
                ),
                const SizedBox(height: 24),

                // Privacy Policy
                _buildSection(
                  title: 'Privacy Policy',
                  content: _getLoremIpsum(),
                ),
                const SizedBox(height: 24),

                // Qo'shimcha bo'limlar
                _buildSection(
                  title: 'User Responsibilities',
                  content: _getLoremIpsum(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // border: Border.all(color: const Color(0xFF2853AF), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _getLoremIpsum() {
    return '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquiet ut vivamus. Odio vulputate est id tincidunt fames.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquiet ut vivamus. Odio vulputate est id tincidunt fames.''';
  }
}