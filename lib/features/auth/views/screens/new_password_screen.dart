import 'package:flutter/material.dart';
import 'package:grand_hotel/core/common/utils/validation_untils.dart';
import 'package:grand_hotel/core/common/widgets/custom_button.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/features/auth/sign_in/sign_in_screen.dart';
import 'package:grand_hotel/features/auth/views/screens/success_dialog.dart';
import 'package:grand_hotel/features/auth/views/widgets/custom_text_field.dart';
import 'package:grand_hotel/main_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool rememberMe = false;

  String? passwordError;
  String? confirmPasswordError;

  void validateInputs() {
    setState(() {
      passwordError = ValidationUtils.validatePassword(passwordController.text);
      confirmPasswordError = ValidationUtils.valideteConfirmPassword(
        passwordController.text,
        confirmPasswordController.text,
      );
    });
  }

  bool get isValid => passwordError == null && confirmPasswordError == null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              const SizedBox(height: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Create a',
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
                    'New Password',
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
                    'Enter your new password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              isDark ? Color(0xFF434E58) : AppColors.textLight,
                        ),
                  ),
                ),
              ]),
              const SizedBox(height: 40),
              CustomTextField(
                label: 'Password',
                hintText: 'Create a password',
                controller: passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                errorText: passwordError,
                onChanged: (value) {
                  validateInputs();
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm Password',
                hintText: 'Confirm your password',
                controller: confirmPasswordController,
                isPassword: true,
                errorText: confirmPasswordError,
                onChanged: (value) {
                  validateInputs();
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Next',
                onPressed: () {
                  validateInputs();
                  if (isValid) {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // tashqarisini bosib yopilmaydi
                      builder: (context) {
                        return SuccessDialog(
                          title: "Success",
                          message: "Your password is successfully created",
                          onContinue: () {
                            Navigator.pop(context); // dialogni yopish
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SignInScreen()),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                isLoading: isLoading,
                isDisabled: !isValid,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
