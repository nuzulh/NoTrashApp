import 'package:flutter/material.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:no_trash/widgets/secondary_button.dart';
import 'package:no_trash/widgets/text_input.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});
  static const RouteName = 'update-profile';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      auth.setDefaultValues();
    });

    return Scaffold(
      backgroundColor: kBgColor,
      body: Layout(
        header: Header(label: 'Perbarui profil', icon: Icons.person),
        child: Consumer<Auth>(
          builder: (context, value, child) => Column(
            children: [
              TextInput(
                label: 'Nama lengkap',
                hintText: '',
                controller: value.name,
              ),
              TextInput(
                label: 'No. HP',
                hintText: '812xxxxxxxx',
                controller: value.phoneNumber,
                textInputType: TextInputType.phone,
                suffixText: '${value.countryCode} ',
              ),
              const SizedBox(height: 30),
              value.loading
                  ? Loading()
                  : PrimaryButton(
                      label: 'Submit',
                      onPressed: () async {
                        await value.updateProfile().then((_) {
                          value.onStart();
                          Navigator.pop(context);
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
