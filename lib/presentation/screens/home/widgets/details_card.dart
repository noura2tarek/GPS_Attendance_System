import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/language/change_language_cubit.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff6ba3be),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            SizedBox(
              width: context
                          .watch<ChangeLanguageCubit>()
                          .state
                          .locale
                          .languageCode ==
                      'en'
                  ? 9
                  : 11,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xfff2f3ff),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xfff2f3ff),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
