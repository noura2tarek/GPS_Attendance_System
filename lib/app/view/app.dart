import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/app_navigator.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/blocs/language/change_language_cubit.dart';
import 'package:gps_attendance_system/blocs/language/change_language_state.dart';
import 'package:gps_attendance_system/blocs/leaves/leaves_bloc.dart';
import 'package:gps_attendance_system/blocs/leaves_admin/leaves_cubit.dart';
import 'package:gps_attendance_system/blocs/theme/theme_bloc.dart';
import 'package:gps_attendance_system/blocs/theme/theme_state.dart';
import 'package:gps_attendance_system/blocs/user_cubit/users_cubit.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/animation/fade.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/admin_home_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/geofence_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/pending_approvals_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/pending_leave_details.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/total_leaves_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/users_page.dart';
import 'package:gps_attendance_system/presentation/screens/auth/add_user_page.dart';
import 'package:gps_attendance_system/presentation/screens/auth/login_page.dart';
import 'package:gps_attendance_system/presentation/screens/home/check_in.dart';
import 'package:gps_attendance_system/presentation/screens/leaves/request_leave_Page.dart';
import 'package:gps_attendance_system/presentation/screens/profile/widgets/reset_password.dart';
import 'package:gps_attendance_system/presentation/screens/settings/settings_page.dart';
import 'package:gps_attendance_system/presentation/screens/user_attendance_history/user_details_page.dart';
import 'package:gps_attendance_system/presentation/screens/user_layout/home_layout.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeLanguageCubit()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(
            create: (context) => AttendanceBloc()..add(FetchCompanyLocation())),
        BlocProvider(
          create: (context) => AuthCubit()..init(),
        ),
        BlocProvider(
          create: (context) => UsersCubit()
            ..getUsers()
            ..getAdminData(),
        ),
        BlocProvider(
          create: (context) => LeavesCubit(),
        ),
        BlocProvider(
          create: (context) {
            return LeaveBloc();
          },
        ),
      ],
      child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeState.themeData,
                locale: languageState.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const AppNavigator(),
                onGenerateRoute: onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.userHome:
      return FadePageTransition(page: const Attendance());
    case AppRoutes.adminHome:
      return FadePageTransition(page: AdminHome());
    case AppRoutes.employees:
      List<UserModel> users = settings.arguments! as List<UserModel>;
      return MaterialPageRoute(
        builder: (context) => UsersPage(users: users, isEmployees: true),
      );
    case AppRoutes.managers:
      List<UserModel> managers = settings.arguments! as List<UserModel>;
      return MaterialPageRoute(
        builder: (context) => UsersPage(users: managers, isEmployees: false),
      );
    case AppRoutes.geofence:
      return MaterialPageRoute(
        builder: (context) => const GeofencePage(),
      );
    case AppRoutes.settings:
      return MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      );
    case AppRoutes.totalLeaves:
      return MaterialPageRoute(
        builder: (context) => TotalLeavesPage(),
      );
    case AppRoutes.pendingApprovals:
      return MaterialPageRoute(
        builder: (context) => const PendingApprovalsPage(),
      );
    case AppRoutes.requestLeave:
      return MaterialPageRoute(
        builder: (context) => const ApplyLeaveScreen(),
      );
    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case AppRoutes.addUser:
      return MaterialPageRoute(
        builder: (context) => const AddUserPage(),
      );
    case AppRoutes.resetPassword:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      );
    case AppRoutes.userDetailsRoute:
      UserModel user = settings.arguments! as UserModel;
      return MaterialPageRoute(
        builder: (context) => UserDetailsPage(userModel: user),
      );
    case AppRoutes.homeLayoutRoute:
      return FadePageTransition(page: const HomeLayout());
    case AppRoutes.pendingLeaveDetails:
      LeaveModel model = settings.arguments! as LeaveModel;
      return MaterialPageRoute(
        builder: (context) => PendingLeaveDetails(model: model),
      );
    default:
      return FadePageTransition(page: const HomeLayout());
  }
}
