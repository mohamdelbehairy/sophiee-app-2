import 'package:app/models/users_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'store_user_date_state.dart';

class StoreUserDateCubit extends Cubit<StoreUserDateState> {
  StoreUserDateCubit() : super(StoreUserDateInitial());

  bool isLoading = false;
  Future<void> storeUserData(
      {required String emailAddress,
      required String userName,
      required String dateOfBirth,
      required String nickName,
      required String bio,
      required String gender,
      required String profileImage,
      String? phoneNumber,
      bool? isEmailAuth
      }) async {
    emit(StoreUserDateLoading(isLoading: true));
    try {
      UserModel userModel = UserModel.fromJson({
        'userName': userName,
        'emailAddress': emailAddress,
        'userID': FirebaseAuth.instance.currentUser!.uid,
        'bio': bio,
        'nickName': nickName,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'profileImage': profileImage,
        'phoneNumber': phoneNumber,
        'onlineStatue': Timestamp.now(),
        'isStory': false,
        'isEmailAuth':isEmailAuth
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.userID)
          .set(userModel.toMap());
      isLoading = false;
      emit(StoreUserDateSuccess());
    } catch (e) {
      emit(StoreUserDateFailure(errorMessage: e.toString()));
      emit(StoreUserDateLoading(isLoading: false));
      debugPrint('error from store user data: ${e.toString()}');
    }
  }
}
