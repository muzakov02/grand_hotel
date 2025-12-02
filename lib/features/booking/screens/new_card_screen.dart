import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/payment_method.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final cleanNameRegex = RegExp(
      r"^(?!\s)(?!.*\s{2,})(?!.*\s$)[A-Za-z\u00C0-\u017F\u0400-\u04FF''-]+(?:\s[A-Za-z\u00C0-\u017F\u0400-\u04FF''-]+)*$");

  // Controllers
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _addCard() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Karta raqamining oxirgi 4 raqamini olish
      final cardNumber = _cardNumberController.text;
      final last4Digits = cardNumber.length >= 4
          ? cardNumber.substring(cardNumber.length - 4)
          : cardNumber;

      // Karta turini aniqlash (birinchi raqamga qarab)
      String cardType = 'card';
      String iconPath = 'assets/icons/card.svg';

      if (cardNumber.startsWith('4')) {
        cardType = 'visa';
        iconPath = 'assets/icons/visa.svg';
      } else if (cardNumber.startsWith('5')) {
        cardType = 'mastercard';
        iconPath = 'assets/icons/mastercard.svg';
      }

      // Yangi karta yaratish
      final newCard = PaymentMethod(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _cardHolderController.text,
        type: cardType,
        cardNumber: '•••• $last4Digits',
        iconPath: iconPath,
      );

      // Orqaga qaytish va kartani yuborish
      Navigator.pop(context, newCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Add New Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        actions: [
          Icon(Icons.more_vert),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/card.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'Card Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter Card Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Card number kiriting';
                    }
                    if (value.length < 16) {
                      return 'To\'liq karta raqamini kiriting';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Card Holder Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _cardHolderController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(cleanNameRegex),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter Holder Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Karta egasining ismini kiriting';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Expired va CVV Code - Row shaklida
                Row(
                  children: [
                    // Expired maydon
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expired',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _expiryController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              _ExpiryDateFormatter(),
                            ],
                            decoration: InputDecoration(
                              hintText: 'MM/YY',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Muddat kiriting';
                              }
                              if (value.length < 5) {
                                return 'MM/YY formatida';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),

                    // CVV Code maydon
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CVV Code',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              hintText: 'CVV',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'CVV kiriting';
                              }
                              if (value.length < 3) {
                                return '3 raqam';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _addCard,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2853AF),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Add Card',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom formatter Expired uchun
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    if (text.length > 4) {
      return oldValue;
    }

    String newText = text.replaceAll('/', '');

    if (newText.length >= 2) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}