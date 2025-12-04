import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/common/utils/validation_untils.dart';
import '../../auth/views/widgets/custom_text_field.dart';

class PersonalInfoScreen extends StatefulWidget {
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialEmail;
  final String? initialPhone;

  const PersonalInfoScreen({
    super.key,
    this.initialFirstName,
    this.initialLastName,
    this.initialEmail,
    this.initialPhone,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? emailError;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.initialFirstName ?? '';
    lastNameController.text = widget.initialLastName ?? '';
    emailController.text = widget.initialEmail ?? '';
    phoneController.text = widget.initialPhone ?? '';

    firstNameController.addListener(_validateForm);
    lastNameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      emailError = ValidationUtils.validateEmail(emailController.text);
    });
  }

  bool _isFormValid() {
    return firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        emailError == null &&
        emailController.text.contains('@');
  }

  void _saveChanges() {
    if (_isFormValid()) {
      Navigator.pop(context, {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
      });
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _isFormValid();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Personal Info',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/edit.svg',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'First Name',
                controller: firstNameController,
                hintText: 'Enter first name',
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Last Name',
                hintText: 'Enter last name',
                controller: lastNameController,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Email',
                hintText: 'Enter email address',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: emailError,
                onChanged: (value) {
                  _validateForm();
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
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Phone',
                hintText: 'Enter phone number',
                controller: phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading || !isFormValid ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: isFormValid
                      ? const Color(0xFF2853AF)
                      : Colors.grey.shade300,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Save Changes',
                        style: TextStyle(
                          color: isFormValid ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
