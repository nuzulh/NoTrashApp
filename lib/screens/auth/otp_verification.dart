import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});
  static const routeName = 'otp-verification';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(label: 'Verifikasi PIN', icon: Icons.pin),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 18),
              child: Column(
                children: [
                  Text(
                    'Silahkan masukkan PIN 6-digit yang dikirim ke',
                    style: GoogleFonts.poppins(),
                  ),
                  Consumer<Auth>(
                    builder: (context, auth, child) => Text(
                      auth.currentUser.email,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Pinput(
                      length: 6,
                      onCompleted: (value) {
                        auth.setOtp(value);
                      },
                      showCursor: true,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Tidak menerima email?',
                        style: GoogleFonts.poppins(),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          ' Minta PIN baru',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: PrimaryButton(label: 'Konfirmasi', onPressed: () {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
