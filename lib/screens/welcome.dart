import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/screens/auth/login.dart';
import 'package:no_trash/screens/screen_tree.dart';
import 'package:no_trash/widgets/app_label.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return auth.firebaseAuth.currentUser != null
        ? const ScreenTree()
        : Scaffold(
            backgroundColor: kBgColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppLabel(),
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Image.asset('assets/images/welcome.png'),
                        ),
                        Text(
                          'Selamat datang.',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Klik mulai untuk melanjutkan.',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: PrimaryButton(
                            label: 'Mulai',
                            onPressed: () {
                              Navigator.pushNamed(context, Login.routeName);
                            },
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
