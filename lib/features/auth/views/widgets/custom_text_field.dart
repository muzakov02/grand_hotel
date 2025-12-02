import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  // final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    // required this.prefixIcon,
    this.isPassword = false,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.keyboardType,
    this.onEditingComplete,
    this.onFieldSubmitted, this.validator, this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? obscureText : false,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: TextStyle(color: isDark ? Colors.white : AppColors.textDark),
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.errorText,
            errorStyle: const TextStyle(color: AppColors.error),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF171725),
              ),
            )
                : null,
            filled: true,
            fillColor: const Color(0xFF9CA4AB).withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
        )

      ],
    );
  }
}
