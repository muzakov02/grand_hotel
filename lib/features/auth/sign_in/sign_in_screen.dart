import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/core/common/widgets/custom_button.dart';
import 'package:grand_hotel/features/auth/sign_in/blog/sign_in_blog.dart';
import 'package:grand_hotel/features/auth/sign_in/blog/sign_in_event.dart';
import 'package:grand_hotel/features/auth/sign_in/blog/sign_in_state.dart';
import 'package:grand_hotel/features/auth/sign_up/sign_up_screen.dart';
import 'package:grand_hotel/features/auth/views/screens/forgot_password_screen.dart';
import 'package:grand_hotel/features/auth/views/widgets/custom_text_field.dart';
import 'package:grand_hotel/features/auth/views/widgets/social_button.dart';
import 'package:grand_hotel/main_screen.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<SignInBloc>();

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                    const SizedBox(height: 20),
                    Text(
                      'Let’s Sign you in',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: isDark ? Colors.white : AppColors.textDark,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      label: 'Email',
                      hintText: 'Enter your email',
                      controller: emailController,
                      errorText: state.emailError,
                      onChanged: (value) =>
                          bloc.add(SignInEvent.emailChanged(value)),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Password',
                      hintText: 'Enter your password',
                      controller: passwordController,
                      isPassword: true,
                      errorText: state.passwordError,
                      onChanged: (value) =>
                          bloc.add(SignInEvent.passwordChanged(value)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: state.rememberMe,
                            shape: const CircleBorder(),
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              bloc.add(SignInEvent.rememberMeToggled(value ?? false));
                            },
                          ),
                        ),
                        const Text("Remember Me"),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Sign In',
                      isLoading: state.isLoading,
                      isDisabled: state.emailError != null ||
                          state.passwordError != null ||
                          state.isLoading,
                      onPressed: () {
                        bloc.add(SignInEvent.submitted(
                          email: emailController.text,
                          password: passwordController.text,
                          rememberMe: state.rememberMe,
                        ));
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text("Sign Up"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SocialButton(icon: 'assets/images/google.png', onPressed: () {}),
                        SocialButton(icon: 'assets/images/apple.png', onPressed: () {}),
                        SocialButton(icon: 'assets/images/facebook.png', onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
