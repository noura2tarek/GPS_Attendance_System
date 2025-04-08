import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/shared_prefs_service.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/widgets/custom_auth_button.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';
import 'package:gps_attendance_system/presentation/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPassword = true;
  IconData icon = Icons.visibility_outlined;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // log in method
  Future<void> _logIn() async {
    if (_formKey.currentState!.validate()) {
      AuthCubit authCubit = AuthCubit.get(context);
      await authCubit.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthStates>(
          listener: (context, state) async {
            if (state is Authenticated) {
              _isLoading = false;
              // check user role first
              // if admin -> navigate to admin dashboard
              // else -> navigate to user home page
              if (state.userRole == Role.admin) {
                bool? mode =
                    SharedPrefsService.getData(key: AppStrings.adminMode)
                        as bool?;
                bool isAdminMode = mode ?? true;
                await Navigator.pushReplacementNamed(
                  context,
                  isAdminMode ? AppRoutes.adminHome : AppRoutes.homeLayoutRoute,
                );
              } else if (state.userRole == Role.employee ||
                  state.userRole == Role.manager) {
                await Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.homeLayoutRoute,
                );
              } else {
                CustomSnackBar.show(
                  context,
                  'User role not found',
                  color: chooseSnackBarColor(ToastStates.ERROR),
                );
              }
            } else if (state is AuthError) {
              CustomSnackBar.show(
                context,
                state.message,
                color: chooseSnackBarColor(ToastStates.ERROR),
              );
              _isLoading = false;
            } else if (state is AuthLoading) {
              _isLoading = true;
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        AppLocalizations.of(context).login,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppLocalizations.of(context).loginToGetStarted,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                    //---------- Email text field ----------//
                    TextFormFieldWidget(
                      labelText: AppLocalizations.of(context).email,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: _validateEmail,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 10),
                    //---------- Password text field ----------//
                    TextFormFieldWidget(
                      labelText: AppLocalizations.of(context).password,
                      obscureText: _isPassword,
                      controller: _passwordController,
                      validator: _validatePassword,
                      prefixIcon: Icons.lock,
                      suffixPressed: () {
                        setState(() {
                          _isPassword = !_isPassword;
                        });
                      },
                      suffixIcon: _isPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    const SizedBox(height: 20),
                    //---------- Login button ----------//
                    BlocBuilder<AuthCubit, AuthStates>(
                      builder: (context, state) {
                        return CustomAuthButton(
                          buttonText: AppLocalizations.of(context).login,
                          isLoading: _isLoading,
                          onTap: _logIn,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Validations
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return AppLocalizations.of(context).validEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return AppLocalizations.of(context).passwordLength;
    }
    return null;
  }
}
