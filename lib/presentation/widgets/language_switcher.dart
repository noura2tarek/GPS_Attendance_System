import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gps_attendance_system/blocs/language/change_language_cubit.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Language Text
        Text(
          AppLocalizations.of(context).language,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: AppColors.secondary,
                iconEnabledColor: AppColors.whiteColor,
                iconDisabledColor: AppColors.whiteColor,
                value: context
                    .watch<ChangeLanguageCubit>()
                    .state
                    .locale
                    .languageCode,
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text(
                      AppLocalizations.of(context).english,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text(
                      AppLocalizations.of(context).arabic,
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<ChangeLanguageCubit>().changeLanguage(value);
                  }
                },
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
