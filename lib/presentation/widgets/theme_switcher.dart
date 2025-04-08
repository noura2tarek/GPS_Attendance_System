import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gps_attendance_system/blocs/theme/theme_bloc.dart';
import 'package:gps_attendance_system/blocs/theme/theme_event.dart';
import 'package:gps_attendance_system/blocs/theme/theme_state.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<ThemeBloc>().state is DarkThemeState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Theme Text
        Text(
          AppLocalizations.of(context).theme,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDarkTheme
                      ? AppLocalizations.of(context).darkTheme
                      : AppLocalizations.of(context).lightTheme,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(width: 10),
                Switch(
                  value: isDarkTheme,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(ToggleTheme());
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
