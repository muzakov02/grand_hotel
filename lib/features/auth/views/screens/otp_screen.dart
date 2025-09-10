import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/features/auth/views/screens/new_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pin1Controller = TextEditingController();
  final TextEditingController _pin2Controller = TextEditingController();
  final TextEditingController _pin3Controller = TextEditingController();
  final TextEditingController _pin4Controller = TextEditingController();

  final FocusNode _pin1Focus = FocusNode();
  final FocusNode _pin2Focus = FocusNode();
  final FocusNode _pin3Focus = FocusNode();
  final FocusNode _pin4Focus = FocusNode();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _pin1Controller.addListener(_checkCodeComplete);
    _pin2Controller.addListener(_checkCodeComplete);
    _pin3Controller.addListener(_checkCodeComplete);
    _pin4Controller.addListener(_checkCodeComplete);
  }

  @override
  void dispose() {
    _pin1Controller.dispose();
    _pin2Controller.dispose();
    _pin3Controller.dispose();
    _pin4Controller.dispose();

    _pin1Focus.dispose();
    _pin2Focus.dispose();
    _pin3Focus.dispose();
    _pin4Focus.dispose();

    super.dispose();
  }

  void _checkCodeComplete() {
    final enabled = _pin1Controller.text.isNotEmpty &&
        _pin2Controller.text.isNotEmpty &&
        _pin3Controller.text.isNotEmpty &&
        _pin4Controller.text.isNotEmpty;
    if (enabled != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = enabled;
      });
    }
  }

  // Agar foydalanuvchi birinchi katakka 4 ta raqam yopishtirib qo'ysa, ularni kataklarga taqsimlaymiz
  void _handlePaste(String pasted) {
    final onlyDigits = pasted.replaceAll(RegExp(r'\D'), '');
    if (onlyDigits.length >= 4) {
      _pin1Controller.text = onlyDigits[0];
      _pin2Controller.text = onlyDigits[1];
      _pin3Controller.text = onlyDigits[2];
      _pin4Controller.text = onlyDigits[3];
      _checkCodeComplete();
      FocusScope.of(context).requestFocus(_pin4Focus);
    }
  }

  Widget _buildPinField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocus,
    FocusNode? prevFocus,
  }) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (value) {
            if (value.length > 1) {
              // paste holatida bir nechta belgilar kirsa - taqsimlashga urinish
              _handlePaste(value);
              return;
            }
            if (value.isNotEmpty) {
              // agar kiritilgan bo'lsa keyingi fokusga o'tamiz
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              } else {
                focusNode.unfocus();
              }
            } else {
              // agar hozirgi katak bo'shashsa (backspace), oldingi katakka o'tish
              if (prevFocus != null) {
                FocusScope.of(context).requestFocus(prevFocus);
                // va ehtimol oldingi katakni tozalashni ham xohlaysiz
                // prevController?.clear();
              }
            }
            _checkCodeComplete();
          },
          // paste va boshqa clipboard hodisalarini tutish uchun:
          onSubmitted: (_) => _checkCodeComplete(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  void _submitCode() {
    final code = _pin1Controller.text +
        _pin2Controller.text +
        _pin3Controller.text +
        _pin4Controller.text;
    // bu yerda network request yoki navgiatsiya qilasiz
    debugPrint('Submitted OTP: $code');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              const SizedBox(height: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Let’s Sign you in',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: isDark ? Colors.white : AppColors.textDark,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              isDark ? Color(0xFF434E58) : AppColors.textLight,
                        ),
                  ),

                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    " ${widget.email}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                      isDark ? Color(0xFF434E58) : AppColors.textLight,
                    ),
                  ),

                ),
              ]),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPinField(
                    controller: _pin1Controller,
                    focusNode: _pin1Focus,
                    nextFocus: _pin2Focus,
                  ),
                  _buildPinField(
                    controller: _pin2Controller,
                    focusNode: _pin2Focus,
                    nextFocus: _pin3Focus,
                    prevFocus: _pin1Focus,
                  ),
                  _buildPinField(
                    controller: _pin3Controller,
                    focusNode: _pin3Focus,
                    nextFocus: _pin4Focus,
                    prevFocus: _pin2Focus,
                  ),
                  _buildPinField(
                    controller: _pin4Controller,
                    focusNode: _pin4Focus,
                    prevFocus: _pin3Focus,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                    _submitCode(); // Avval kodni tekshirasiz

                    // Keyin boshqa sahifaga yo'naltirish
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewPasswordScreen(), // o'z sahifangizni yozing
                      ),
                    );
                  }
                      : null,
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size(screenWidth * 0.9, 60)),
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                          (states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey.shade400;
                        }
                        return AppColors.primary;
                      },
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn’t receive code?",
                      style: TextStyle(fontSize: 15, color: Colors.grey)),
                  TextButton(
                    onPressed: () {
                      // Barcha kataklarni tozalash
                      _pin1Controller.clear();
                      _pin2Controller.clear();
                      _pin3Controller.clear();
                      _pin4Controller.clear();

                      // Fokusni birinchi katakka qaytarish
                      FocusScope.of(context).requestFocus(_pin1Focus);

                      // Button disable bo‘lishi uchun holatni yangilash
                      setState(() {
                        _isButtonEnabled = false;
                      });

                      // Bu yerda resend API chaqirishingiz ham mumkin
                      debugPrint("Resend OTP to ${widget.email}");
                    },
                    child: Text(
                      "Resend Code",
                      style: TextStyle(fontSize: 15, color: AppColors.primary),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
