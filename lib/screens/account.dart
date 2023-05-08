import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/widgets/inline_text.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/screen_label.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Layout(
      child: Column(
        children: [
          ScreenLabel(icon: Icons.account_circle, label: 'Akun'),
          CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: 38),
          ),
          TextButton(
            onPressed: () {},
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
                    auth.currentUser.email,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(),
                  ),
                  Icon(
                    auth.firebaseAuth.currentUser!.emailVerified
                        ? Icons.check_circle_outline_rounded
                        : Icons.info_outline_rounded,
                    color: auth.firebaseAuth.currentUser!.emailVerified
                        ? Colors.green
                        : Colors.redAccent,
                    size: 20,
                  ),
                  auth.firebaseAuth.currentUser!.emailVerified
                      ? SizedBox.shrink()
                      : InkWell(
                          onTap: () {},
                          child: Text(
                            ' Verifikasi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: kPrimaryColor,
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
              value: auth.currentUser.name,
            ),
          ),
          Divider(color: Colors.black54, height: 1),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: InlineText(
              label: 'No. HP',
              value: auth.countryCode + auth.currentUser.phoneNumber,
            ),
          ),
          Divider(color: Colors.black54, height: 1),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: InlineText(
              label: 'Kategori pengguna',
              value: auth.currentUser.role,
            ),
          ),
          Divider(color: Colors.black54, height: 1),
          InkWell(
            onTap: () => auth.signOut(context),
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
    );
  }
}
