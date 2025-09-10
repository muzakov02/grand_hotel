import 'package:flutter/material.dart';
import 'package:grand_hotel/core/common/utils/validation_untils.dart';
import 'package:grand_hotel/core/common/widgets/custom_button.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/features/auth/views/screens/otp_screen.dart';
import 'package:grand_hotel/features/auth/views/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  String? emailError;

  void validateInputs() {
    setState(() {
      emailError = ValidationUtils.validateEmail(emailController.text);
    });
  }

  bool get isValid => emailError == null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
                    'Forgot Password',
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
                    'Recover your account password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              isDark ? Color(0xFF434E58) : AppColors.textLight,
                        ),
                  ),
                ),
              ]),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Email',
                hintText: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: emailError,
                onChanged: (value) {
                  validateInputs();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Next',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        email: emailController.text,
                      ),
                    ),
                  );
                },
                isLoading: false,   // bu bosilganda loader qo‘yish uchun
                isDisabled: emailController.text.isEmpty, // email bo‘sh bo‘lsa disable
              ),

            ],
          ),
        ),
      ),
    );
  }
}
