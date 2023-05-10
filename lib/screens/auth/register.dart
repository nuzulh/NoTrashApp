import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/screens/auth/login.dart';
import 'package:no_trash/widgets/dropdown_menu.dart';
import 'package:no_trash/widgets/error_text.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:no_trash/widgets/text_input.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  const Register({super.key});
  static const routeName = 'register';

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
                    'Daftar',
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
                        CustomDropdownMenu(
                          hintText: 'Daftar sebagai',
                          items: auth.roles,
                          onChanged: (value) {
                            auth.setRole(value);
                          },
                        ),
                        TextInput(
                          label: 'Nama lengkap',
                          hintText: 'Nama User',
                          controller: auth.name,
                        ),
                        TextInput(
                          label: 'No. HP',
                          hintText: '812xxxxxxxx',
                          controller: auth.phoneNumber,
                          textInputType: TextInputType.phone,
                          suffixText: '${auth.countryCode} ',
                        ),
                        TextInput(
                          label: 'Email',
                          textInputType: TextInputType.emailAddress,
                          hintText: 'user@email.com',
                          controller: auth.email,
                        ),
                        TextInput(
                          isPassword: true,
                          label: 'Password',
                          hintText: '********',
                          controller: auth.password,
                        ),
                        TextInput(
                          isPassword: true,
                          label: 'Konfirmasi password',
                          hintText: '********',
                          controller: auth.confirmPassword,
                        ),
                      ],
                    ),
                  ),
                  auth.loading
                      ? const Loading()
                      : PrimaryButton(
                          label: 'Daftar',
                          onPressed: () {
                            auth.createUserWithEmailAndPassword(context);
                          },
                        ),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      Login.routeName,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun? ',
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          'login.',
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
