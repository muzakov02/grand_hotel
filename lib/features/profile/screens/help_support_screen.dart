import 'package:flutter/material.dart';

// FAQ klassi qo'shildi
class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Support'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 24),
            _buildFAQSection(), // const o'chirildi va metod nomi to'g'rilandi
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    final faqs = [
      FAQ(
        question: 'How do I track my order?',
        answer:
        'You can track your order by going to My Orders in your profile and selecting the specific order. There you will find real-time tracking information and estimated delivery date.',
      ),
      FAQ(
        question: 'What is your return policy?',
        answer:
        'We offer a 30-day return policy for most items. The item must be unused and in its original packaging. Refunds will be processed within 5-7 business days after we receive the returned item.',
      ),
      FAQ(
        question: 'How long does delivery take?',
        answer:
        'Delivery typically takes 3-5 business days for standard shipping. Express shipping options are available at checkout for faster delivery within 1-2 business days.',
      ),
      FAQ(
        question: 'Do you offer assembly services?',
        answer:
        'Yes, we offer professional assembly services for most furniture items. You can select this option during checkout. Our trained technicians will assemble your furniture at your preferred location.',
      ),
      FAQ(
        question: 'What payment methods do you accept?',
        answer:
        'We accept all major credit cards, debit cards, PayPal, and bank transfers. You can also choose cash on delivery for eligible orders in selected areas.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            // border: Border.all(color: Colors.grey.shade300),
          ),
          child: ExpansionPanelList.radio(
            elevation: 0,
            dividerColor: Colors.grey.shade300,
            expandedHeaderPadding: EdgeInsets.zero,
            children: faqs
                .map(
                  (faq) => ExpansionPanelRadio(
                value: faq.question,
                backgroundColor: Colors.white,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) => ListTile(
                  title: Text(
                    faq.question,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isExpanded ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
                body: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: Text(
                    faq.answer,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}