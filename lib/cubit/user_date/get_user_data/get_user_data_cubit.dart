import 'package:app/constants.dart';
import 'package:app/cubit/user_date/get_user_data/get_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserDataCubit extends Cubit<GetUserDataStates> {
  GetUserDataCubit() : super(GetUserDataInitial());

  void getUserData() {
    emit(GetUserDataLoading());
    try {
      FirebaseFirestore.instance.collection(userCollection).snapshots().listen(
        (snapshot) {
          if (snapshot.docs.isNotEmpty) {
            List<UserModel> users = snapshot.docs
                .map((doc) => UserModel.fromJson(doc.data()))
                .toList();
            if (users.isNotEmpty) {
              emit(GetUserDataSuccess(userModel: users));
            }
          }
        },
      );
    } catch (e) {
      emit(GetUserDataFailure(errorMessage: e.toString()));
      debugPrint(e.toString());
    }
  }
}
