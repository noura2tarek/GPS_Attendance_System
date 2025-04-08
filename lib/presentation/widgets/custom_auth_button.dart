import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    required this.buttonText,
    required this.isLoading,
    super.key,
    this.onTap,
  });

  final String buttonText;
  final bool isLoading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: onTap,
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  buttonText,
                ),
        ),
      ),
    );
  }
}
