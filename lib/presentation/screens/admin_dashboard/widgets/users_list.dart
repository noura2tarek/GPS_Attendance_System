import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_list_tile.dart';

class UsersList extends StatelessWidget {
  const UsersList({required this.users, super.key});

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 8),
          child: CustomListTile(
            leadingWidget: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(user.getAvatarImage()),
            ),
            title: user.name,
            subtitle: user.email,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.userDetailsRoute,
                // send to this page attendance list of this user & user model
                // as arguments
                arguments: user,
              );
            },
          ),
        );
      },
    );
  }
}
