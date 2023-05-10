import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/screens/auth/register.dart';
import 'package:no_trash/widgets/error_text.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:no_trash/widgets/success_dialog.dart';
import 'package:no_trash/widgets/text_input.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});
  static const routeName = 'reset-password';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: kBgColor,
      body: Layout(
        header: Header(label: 'Reset password', icon: Icons.password_rounded),
        child: Consumer<Auth>(
          builder: (context, value, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  'Silahkan masukkan alamat email akun Anda. Kami akan mengirim link untuk reset password.',
                  style: GoogleFonts.poppins(),
                ),
              ),
              TextInput(
                label: 'Email',
                hintText: 'user@email.com',
                textInputType: TextInputType.emailAddress,
                controller: value.email,
              ),
              value.loading
                  ? Loading()
                  : PrimaryButton(
                      label: 'Kirim',
                      icon: Icons.mail_outlined,
                      onPressed: () async {
                        await value
                            .sendPasswordResetEmail(value.email.text)
                            .then((sent) {
                          if (sent) {
                            showDialog(
                              context: context,
                              builder: (context) => SuccessDialog(
                                text:
                                    'Link reset password berhasil dikirim ke ${value.email.text}. Silahkan cek email Anda.',
                                buttonLabel: 'OK',
                                onAction: () => Navigator.pop(context),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.warning_rounded,
                                      color: Colors.white,
                                    ),
                                    Text(' ${value.error}'),
                                  ],
                                ),
                              ),
                            );
                          }
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
