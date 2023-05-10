import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:no_trash/models/user.dart';
import 'package:no_trash/screens/auth/login.dart';
import 'package:no_trash/screens/screen_tree.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final List<String> roles = ['Petugas', 'Pelapor'];
  final String countryCode = '+62';
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  TextEditingController get name => _name;
  TextEditingController get email => _email;
  TextEditingController get phoneNumber => _phoneNumber;
  TextEditingController get password => _password;
  TextEditingController get confirmPassword => _confirmPassword;

  late UserModel _currentUser;
  String _verificationId = '';
  String _error = '';
  bool _loading = false;
  String _selectedRole = '';
  String _otp = '';
  Timer? _timer;

  UserModel get currentUser => _currentUser;
  String get verificationId => _verificationId;
  String get error => _error;
  bool get loading => _loading;
  String get selectedRole => _selectedRole;
  String get otp => _otp;
  Timer? get timer => _timer;

  Auth() {
    onStart();
    resetError();
  }

  void onStart() async {
    final currentUser = await getUserData();
    _currentUser = currentUser;
    notifyListeners();
  }

  void startLoading() {
    _loading = true;
    notifyListeners();
  }

  void stopLoading() {
    resetForm();
    _loading = false;
    notifyListeners();
  }

  void setRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  void setOtp(String otp) {
    _otp = otp;
    notifyListeners();
  }

  void resetError() {
    _error = '';
    notifyListeners();
  }

  void resetForm() {
    _selectedRole = '';
    _name.text = '';
    _phoneNumber.text = '';
    _email.text = '';
    _password.text = '';
    _confirmPassword.text = '';
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  bool checkRegisterForm() {
    if (_selectedRole.isEmpty ||
        _name.text.isEmpty ||
        _email.text.isEmpty ||
        _password.text.isEmpty ||
        _confirmPassword.text.isEmpty) {
      stopLoading();
      setError('Isian belum lengkap');
      return false;
    }
    if (_password.text != _confirmPassword.text) {
      stopLoading();
      setError('Password tidak sama');
      return false;
    }
    return true;
  }

  bool checkLoginForm() {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      setError('Isian belum lengkap');
      stopLoading();
      return false;
    }
    return true;
  }

  void setDefaultValues() {
    _name.text = currentUser.name;
    _phoneNumber.text = currentUser.phoneNumber;
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword(context) async {
    resetError();
    startLoading();
    try {
      if (checkRegisterForm()) {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        await updateUserData();
        stopLoading();
        Navigator.pushNamedAndRemoveUntil(
          context,
          ScreenTree.routeName,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (error) {
      _error = error.message.toString();
      notifyListeners();
      stopLoading();
    }
  }

  Future<void> signInWithEmailAndPassword(context) async {
    resetError();
    startLoading();
    try {
      if (checkLoginForm()) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        stopLoading();
        Navigator.pushNamedAndRemoveUntil(
          context,
          ScreenTree.routeName,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (error) {
      _error = error.message.toString();
      notifyListeners();
      stopLoading();
    }
  }

  Future<void> updateUserData() async {
    try {
      await db
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .set(UserModel(
            id: firebaseAuth.currentUser!.uid,
            role: _selectedRole,
            name: _name.text,
            email: _email.text,
            phoneNumber: _phoneNumber.text,
          ).toJson());
    } catch (error) {
      stopLoading();
      _error = error.toString();
    }
  }

  Future<void> updateProfile() async {
    try {
      startLoading();
      await db
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .set(UserModel(
            id: firebaseAuth.currentUser!.uid,
            role: currentUser.role,
            name: _name.text,
            email: currentUser.email,
            phoneNumber: _phoneNumber.text,
          ).toJson());
      stopLoading();
    } catch (error) {
      stopLoading();
      _error = error.toString();
    }
  }

  Future<UserModel> getUserData() async {
    startLoading();
    try {
      final res =
          await db.collection('users').doc(firebaseAuth.currentUser!.uid).get();
      stopLoading();
      return UserModel.fromJson(res.data()!);
    } catch (error) {
      stopLoading();
      return UserModel.fromJson({});
    }
  }

  Future<UserModel> getUserById(String id) async {
    startLoading();
    try {
      final res = await db.collection('users').doc(id).get();
      stopLoading();
      return UserModel.fromJson(res.data()!);
    } catch (error) {
      stopLoading();
      return UserModel.fromJson({});
    }
  }

  Future<void> verifyPhoneNumber() async {
    resetError();
    startLoading();
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: countryCode + phoneNumber.text.trim(),
      verificationCompleted: (PhoneAuthCredential credencial) async {
        await firebaseAuth.signInWithCredential(credencial);
        stopLoading();
      },
      codeSent: (String verificationId, resendToken) {
        _verificationId = verificationId;
        notifyListeners();
        stopLoading();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        notifyListeners();
        stopLoading();
      },
      verificationFailed: (FirebaseAuthException e) {
        _error = e.message.toString();
        notifyListeners();
        stopLoading();
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    resetError();
    startLoading();
    UserCredential credential = await firebaseAuth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      ),
    );
    stopLoading();
    return credential.user != null ? true : false;
  }

  Future<bool> verifyEmail() async {
    resetError();
    startLoading();
    try {
      final User user = firebaseAuth.currentUser!;
      await user.sendEmailVerification();
      _timer = Timer.periodic(Duration(seconds: 10), (_) {
        _timer = null;
        notifyListeners();
      });
      notifyListeners();
      stopLoading();
      return true;
    } on FirebaseAuthException catch (err) {
      setError(err.toString());
      stopLoading();
      return false;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    startLoading();
    try {
      if (email != '') {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        stopLoading();
        return true;
      } else {
        setError('Harap mengisi email');
        stopLoading();
        return false;
      }
    } on FirebaseAuthException catch (err) {
      setError(err.message.toString());
      stopLoading();
      return false;
    }
  }

  Future<void> signOut(context) async {
    startLoading();
    await firebaseAuth.signOut();
    stopLoading();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Login.routeName,
      (route) => false,
    );
  }
}
