import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/screens/auth/update_profile.dart';
import 'package:no_trash/widgets/inline_text.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/screen_label.dart';
import 'package:no_trash/widgets/success_dialog.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      auth.onStart();
    });

    return Stack(
      children: [
        Layout(
          child: Consumer<Auth>(
            builder: (context, value, child) => Column(
              children: [
                ScreenLabel(icon: Icons.account_circle, label: 'Akun'),
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 38),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    UpdateProfile.RouteName,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Perbarui profil',
                        style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, color: kPrimaryColor),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: InlineText(
                    label: 'Email',
                    child: Row(
                      children: [
                        Text(
                          value.currentUser.email,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(),
                        ),
                        Icon(
                          value.firebaseAuth.currentUser?.emailVerified ?? false
                              ? Icons.check_circle_outline_rounded
                              : Icons.info_outline_rounded,
                          color:
                              value.firebaseAuth.currentUser?.emailVerified ??
                                      false
                                  ? Colors.green
                                  : Colors.redAccent,
                          size: 20,
                        ),
                        value.firebaseAuth.currentUser?.emailVerified ?? false
                            ? SizedBox.shrink()
                            : InkWell(
                                onTap: () async {
                                  if (value.timer == null) {
                                    await value.verifyEmail().then((sent) {
                                      if (sent) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => SuccessDialog(
                                            text:
                                                'Silahkan klik link yang dikirim ke email ${value.currentUser.email}',
                                            buttonLabel: 'OK',
                                            onAction: () =>
                                                Navigator.pop(context),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                    ' Gagal mengirim link verifikasi'),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  ' Verifikasi',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                    color: value.timer == null
                                        ? kPrimaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.black54, height: 1),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: InlineText(
                    label: 'Nama',
                    value: value.currentUser.name,
                  ),
                ),
                Divider(color: Colors.black54, height: 1),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: InlineText(
                    label: 'No. HP',
                    value: value.countryCode + value.currentUser.phoneNumber,
                  ),
                ),
                Divider(color: Colors.black54, height: 1),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: InlineText(
                    label: 'Kategori pengguna',
                    value: value.currentUser.role,
                  ),
                ),
                Divider(color: Colors.black54, height: 1),
                InkWell(
                  onTap: () async {
                    await value
                        .sendPasswordResetEmail(value.currentUser.email)
                        .then((sent) {
                      if (sent) {
                        showDialog(
                          context: context,
                          builder: (context) => SuccessDialog(
                            text:
                                'Link reset password berhasil dikirim ke ${value.currentUser.email}. Silahkan cek email Anda.',
                            buttonLabel: 'OK',
                            onAction: () {
                              Navigator.pop(context);
                              value.signOut(context);
                            },
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: InlineText(
                      label: 'Reset password',
                      child: Icon(
                        Icons.chevron_right_rounded,
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.black54, height: 1),
                InkWell(
                  onTap: () => value.signOut(context),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: InlineText(
                      label: 'Keluar',
                      color: Colors.redAccent,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.black54, height: 1),
              ],
            ),
          ),
        ),
        Consumer<Auth>(
          builder: (context, value, child) => value.loading
              ? Container(
                  color: Colors.black26,
                  child: Loading(),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
