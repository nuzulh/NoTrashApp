import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/providers/maps.dart';
import 'package:no_trash/providers/navigation.dart';
import 'package:no_trash/providers/report.dart';
import 'package:no_trash/screens/auth/login.dart';
import 'package:no_trash/screens/auth/otp_verification.dart';
import 'package:no_trash/screens/auth/register.dart';
import 'package:no_trash/screens/reporter/location_picker.dart';
import 'package:no_trash/screens/officer/index.dart';
import 'package:no_trash/screens/reporter/index.dart';
import 'package:no_trash/screens/reporter/report_form.dart';
import 'package:no_trash/screens/report_list.dart';
import 'package:no_trash/screens/screen_tree.dart';
import 'package:no_trash/screens/welcome.dart';
import 'package:no_trash/screens/report_detail.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const NoTrash());
}

class NoTrash extends StatelessWidget {
  const NoTrash({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Report()),
        ChangeNotifierProvider(create: (context) => Navigation()),
        ChangeNotifierProvider(create: (context) => Maps()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(14),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: kPrimaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        home: const Welcome(),
        routes: {
          ScreenTree.routeName: (context) => const ScreenTree(),
          Login.routeName: (context) => const Login(),
          Register.routeName: (context) => const Register(),
          OtpVerification.routeName: (context) => const OtpVerification(),
          ReportDetail.routeName: (context) => const ReportDetail(),
          ReportForm.routeName: (context) => const ReportForm(),
          OfficerIndex.routeName: (context) => const OfficerIndex(),
          ReporterIndex.routeName: (context) => const ReporterIndex(),
          ReportList.routeName: (context) => const ReportList(),
          LocationPicker.routeName: (context) => const LocationPicker(),
        },
      ),
    );
  }
}
