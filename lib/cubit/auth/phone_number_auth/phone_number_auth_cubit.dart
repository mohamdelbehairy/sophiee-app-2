import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'phone_number_auth_state.dart';

class PhoneNumberAuthCubit extends Cubit<PhoneNumberAuthState> {
  PhoneNumberAuthCubit() : super(PhoneNumberAuthInitial());

  String verificationID = '';
  bool isLoading = false;
  Future<void> signInWithPhoneNumber({required String phoneNumber}) async {
    emit(PhoneNumberAuthLoading(isLoading: true));
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        emit(SendPhoneNumberAuthFailure(errorMessage: e.toString()));
        debugPrint(
            'error from sign in with phone number method: ${e.toString()}');
        isLoading = false;
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(SendPhoneNumberAuthSuccess());
        verificationID = verificationId;
        isLoading = false;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyPhoneNumber({required String smsCode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);

      await FirebaseAuth.instance.signInWithCredential(credential);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userID', FirebaseAuth.instance.currentUser!.uid);
      emit(VerifyPhoneNumberAuthSuccess());
    } catch (e) {
      emit(VerifyPhoneNumberAuthFailure(errorMessage: e.toString()));
      debugPrint('error from verify phone number method: ${e.toString()}');
    }
  }
}
