import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _resetPassword() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      CustomSnackBar.show(
        context,
        AppLocalizations.of(context).pleaseEnterEmail,
        color: Colors.red,
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);

      CustomSnackBar.show(
        context,
        AppLocalizations.of(context).passwordResetEmailSent,
        color: Colors.green,
      );
    } catch (e) {
      CustomSnackBar.show(
        context,
        '${AppLocalizations.of(context).failedToResetPassword}$e',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).resetPassword),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).email,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child:  Text(AppLocalizations.of(context).sendResetEmail),
            ),
          ],
        ),
      ),
    );
  }
}
