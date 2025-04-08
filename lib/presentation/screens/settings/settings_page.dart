import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/models/setting_manager.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/shared_prefs_service.dart';
import 'package:gps_attendance_system/core/services/user_services.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_list_tile.dart';
import 'package:gps_attendance_system/presentation/widgets/widget_factory.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsManager settingsManager = SettingsManager();
  String text = 'Switch to User Mode';
  IconData icon = Icons.person;
  bool isAdminMode = true;

  // Toggle user mode
  Future<void> _toggleMode() async {
    setState(() {
      if (isAdminMode) {
        text = 'Switch to User Mode';
        icon = Icons.person;
        settingsManager.switchToUserMode(
          context: context,
        );
      } else {
        text = 'Switch to Admin Mode';
        icon = Icons.admin_panel_settings;
        settingsManager.switchToAdminMode(
          context: context,
        );
      }
      isAdminMode = !isAdminMode;
    });
    await SharedPrefsService.saveData(
      key: AppStrings.adminMode,
      value: isAdminMode,
    );
  }

  Role? userRole;

  // Get saved mode
  Future<void> _getSavedMode() async {
    bool? mode = SharedPrefsService.getData(key: AppStrings.adminMode) as bool?;
    setState(() {
      isAdminMode = mode ?? true;
      text = isAdminMode ? 'Switch to User Mode' : 'Switch to Admin Mode';
      icon = isAdminMode ? Icons.person : Icons.admin_panel_settings;
    });
  }

  // Get user data to check user role
  Future<void> _getUserData() async {
    String? role =
        SharedPrefsService.getData(key: AppStrings.roleKey) as String?;
    if (role == null || role.isEmpty) {
      String? uid = SharedPrefsService.getData(key: AppStrings.id) as String?;
      uid ??= UserService.authInstance.currentUser!.uid;
      UserModel? userModel = await UserService.getUserData(uid);
      setState(() {
        userRole = userModel?.role;
      });
    } else {
      if (role == 'admin') {
        setState(() {
          userRole = Role.admin;
        });
      }
    }
  }

  @override
  void initState() {
    _getUserData();
    _getSavedMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        leading: IconButton(
          onPressed: () => settingsManager.goToProfile(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 40,
          children: [
            WidgetFactory.createWidget('language'),
            WidgetFactory.createWidget('theme'),
            //--- switch to user mode ---//
            Visibility(
              visible: userRole == Role.admin,
              child: Card(
                child: CustomListTile(
                  title: text,
                  isUser: false,
                  leadingWidget: Icon(
                    icon,
                  ),
                  onTap: _toggleMode,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
