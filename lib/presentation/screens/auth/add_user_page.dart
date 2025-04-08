import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/widgets/custom_auth_button.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';
import 'package:gps_attendance_system/presentation/widgets/text_form_field.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({
    super.key,
  });

  @override
  State<AddUserPage> createState() => AddUserPageState();
}

class AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  bool _isLoading = false;
  Role _selectedRole = Role.employee;
  String _selectedGender = 'male';

  // add new user function
  void _addNewUser() async {
    if (_formKey.currentState!.validate()) {
      UserModel userModel = UserModel(
        name: _fullNameController.text,
        email: _emailController.text,
        role: _selectedRole,
        contactNumber: _contactController.text,
        position: _positionController.text,
        gender: _selectedGender,
      );

      AuthCubit authCubit = AuthCubit.get(context);
      await authCubit.addUser(
        email: _emailController.text,
        password: _passwordController.text,
        userModel: userModel,
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _contactController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).addUser,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AccountCreated) {
            CustomSnackBar.show(
              context,
              'Account Created Successfully',
              color: chooseSnackBarColor(ToastStates.SUCCESS),
            );
            _isLoading = false;
            _emailController.clear();
            _passwordController.clear();
            _fullNameController.clear();
            _confirmPasswordController.clear();
            _positionController.clear();
            _contactController.clear();
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
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //----------- Full Name text field ----------//
                    TextFormFieldWidget(
                      keyboardType: TextInputType.name,
                      labelText: AppLocalizations.of(context).fullName,
                      hintText: AppLocalizations.of(context).enterFullName,
                      controller: _fullNameController,
                      validator: _validateFullName,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 10),
                    //----------- Email text field ----------//
                    TextFormFieldWidget(
                      labelText: AppLocalizations.of(context).email,
                      hintText: AppLocalizations.of(context).enterEmail,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: _validateEmail,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 10),
                    //----------- Password text field ----------//
                    TextFormFieldWidget(
                      keyboardType: TextInputType.visiblePassword,
                      labelText: AppLocalizations.of(context).password,
                      hintText: AppLocalizations.of(context).enterPassword,
                      obscureText: isPasswordObscure,
                      controller: _passwordController,
                      validator: _validatePassword,
                      prefixIcon: Icons.lock,
                      suffixPressed: () {
                        setState(() {
                          isPasswordObscure = !isPasswordObscure;
                        });
                      },
                      suffixIcon: isPasswordObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    const SizedBox(height: 10),
                    //----------- Confirm Password text field ----------//
                    TextFormFieldWidget(
                      keyboardType: TextInputType.visiblePassword,
                      labelText: AppLocalizations.of(context).confirmPassword,
                      hintText:
                          AppLocalizations.of(context).enterConfirmPassword,
                      obscureText: isConfirmPasswordObscure,
                      controller: _confirmPasswordController,
                      validator: _validateConfirmPassword,
                      prefixIcon: Icons.lock,
                      suffixPressed: () {
                        setState(() {
                          isConfirmPasswordObscure = !isConfirmPasswordObscure;
                        });
                      },
                      suffixIcon: isConfirmPasswordObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    //----------- Phone text field ----------//
                    TextFormFieldWidget(
                      labelText: AppLocalizations.of(context).phone,
                      hintText: AppLocalizations.of(context).enterPhone,
                      keyboardType: TextInputType.number,
                      controller: _contactController,
                      validator: _validatePhone,
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(height: 10),
                    //----------- Position text field ----------//
                    TextFormFieldWidget(
                      labelText: AppLocalizations.of(context).position,
                      hintText: AppLocalizations.of(context).enterPosition,
                      keyboardType: TextInputType.text,
                      controller: _positionController,
                      validator: _validatePosition,
                      prefixIcon: Icons.work,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.all(8),
                      child: Text(
                        AppLocalizations.of(context).selectUserRole,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    //-- Radio buttons to select user role --//
                    Row(
                      children: [
                        // Employee radio button
                        Radio<Role>(
                          value: Role.employee,
                          groupValue: _selectedRole,
                          activeColor: AppColors.fourthColor,
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value!;
                            });
                          },
                        ),
                        Text(AppLocalizations.of(context).employee),
                        // Manager radio button
                        Radio<Role>(
                          value: Role.manager,
                          groupValue: _selectedRole,
                          activeColor: AppColors.fourthColor,
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value!;
                            });
                          },
                        ),
                        Text(AppLocalizations.of(context).manager),
                        // Admin radio button
                        Radio<Role>(
                          value: Role.admin,
                          groupValue: _selectedRole,
                          activeColor: AppColors.fourthColor,
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value!;
                            });
                          },
                        ),
                        Text(AppLocalizations.of(context).admin),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsetsDirectional.all(8),
                      child: Text(
                        AppLocalizations.of(context).selectGender,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    //-- Radio buttons to select gender --//
                    Row(
                      children: [
                        Radio<String>(
                          value: 'male',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text(AppLocalizations.of(context).male),
                        Radio<String>(
                          value: 'female',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text(AppLocalizations.of(context).female),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //----------- Add User Button ----------//
                    BlocBuilder<AuthCubit, AuthStates>(
                      builder: (context, state) {
                        return CustomAuthButton(
                          buttonText: AppLocalizations.of(context).addUser,
                          isLoading: _isLoading,
                          onTap: _addNewUser,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Validations --------------
  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterFullName;
    } else if (!value.startsWith(RegExp(r'[A-Z]'))) {
      return AppLocalizations.of(context).fullNameCapital;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterEmail;
    } else if (!value.contains('@')) {
      return AppLocalizations.of(context).validEmail;
    }
    return null;
  }

  String? _validatePosition(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterPosition;
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty || value.length != 11) {
      return AppLocalizations.of(context).validPhone;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return AppLocalizations.of(context).passwordLength;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return AppLocalizations.of(context).passwordMismatch;
    }
    return null;
  }
}
