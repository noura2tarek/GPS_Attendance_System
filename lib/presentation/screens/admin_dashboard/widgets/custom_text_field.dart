import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.labelText,
    required this.hintText,
    required this.context,
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isDropdown = false,
    this.isDateField = false,
    this.dropdownItems,
    this.onChanged,
    this.onDateTap,
  });

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isDropdown;
  final bool isDateField;
  final List<String>? dropdownItems;
  final void Function(String?)? onChanged;
  final VoidCallback? onDateTap;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: isDropdown
          ? DropdownButtonFormField<String>(
              decoration: _buildInputDecoration(context: context),
              items: dropdownItems
                  ?.map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            )
          : TextFormField(
              cursorColor: AppColors.primary,
              controller: controller,
              keyboardType: keyboardType,
              readOnly: isDateField,
              onTap: isDateField ? onDateTap : null,
              decoration: _buildInputDecoration(
                suffixIcon: isDateField ? Icons.calendar_today : null,
                context: context,
              ),
              validator: (value) => value == null || value.isEmpty
                  ? '${AppLocalizations.of(context).pleaseEnter}$labelText'
                  : null,
            ),
    );
  }

  InputDecoration _buildInputDecoration(
      {required BuildContext context, IconData? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.thirdMintGreen),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.thirdMintGreen),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.fifthColor),
      ),
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: AppColors.fourthColor)
          : null,
    );
  }
}
