import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verifikasi',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        'Silahkan masukkan kode yang dikirim ke nomor',
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 18),
                      Consumer<Auth>(
                        builder: (context, auth, child) => Text(
                          auth.countryCode + auth.phoneNumber.text,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Pinput(
                        length: 6,
                        onCompleted: (value) {
                          auth.setOtp(value);
                        },
                        showCursor: true,
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  label: "Verifikasi",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
