import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    required this.containerTitles,
    required this.index,
    required this.icons,
    required this.countNumber,
    super.key,
  });

  final List<String> containerTitles;
  final List<IconData> icons;
  final int index;
  final int countNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          // navigate to total leaves page
          Navigator.pushNamed(context, AppRoutes.totalLeaves);
        } else if (index == 3) {
          // navigate to pending approvals page
          Navigator.pushNamed(context, AppRoutes.pendingApprovals);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              blurRadius: 4,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(17),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total employees or managers
              Text(
                countNumber.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // title and icon row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    containerTitles[index],
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    icons[index],
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
