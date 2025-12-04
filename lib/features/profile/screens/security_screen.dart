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
          thumbColor: const Color(0xFF2853AF),
          thickness: 8.0,
          radius: const Radius.circular(10),
          thumbVisibility: true,
          trackVisibility: false,
          trackColor: Colors.grey.shade200,
          trackBorderColor: Colors.transparent,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'Terms',
                  content: _getLoremIpsum(),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Changes to the Service and/or Terms:',
                  content: _getLoremIpsum(),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Privacy Policy',
                  content: _getLoremIpsum(),
                ),
                const SizedBox(height: 24),
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
