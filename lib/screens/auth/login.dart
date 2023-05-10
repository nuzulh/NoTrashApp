import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/screens/auth/register.dart';
import 'package:no_trash/screens/auth/reset_password.dart';
import 'package:no_trash/widgets/error_text.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:no_trash/widgets/text_input.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Masuk',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    child: Column(
                      children: [
                        ErrorText(text: auth.error),
                        TextInput(
                          controller: auth.email,
                          textInputType: TextInputType.emailAddress,
                          label: 'Email',
                          hintText: 'user@email.com',
                        ),
                        TextInput(
                          controller: auth.password,
                          isPassword: true,
                          label: 'Password',
                          hintText: '********',
                        ),
                      ],
                    ),
                  ),
                  auth.loading
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 22),
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: kPrimaryColor,
                          ),
                        )
                      : PrimaryButton(
                          label: 'Masuk',
                          onPressed: () {
                            auth.signInWithEmailAndPassword(context);
                          },
                        ),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ResetPassword.routeName,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lupa password? ',
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          'reset password.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      Register.routeName,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          'daftar.',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
