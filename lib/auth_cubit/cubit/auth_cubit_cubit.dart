import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:videalpha/customerror.dart';
import 'package:videalpha/firebaseAuthRepository/FireaseauthRepository.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthcubitState> {
  final FireaseauthRepository fireaseauthRepository;
  final BuildContext? context;
  AuthCubitCubit({required this.fireaseauthRepository, this.context})
      : super(AuthcubitState.initial());

  FutureOr<void> Authverification(
      {required String phonenumber, context}) async {
    emit(state.copyWith(autthstatus: Autthstatus.loading));
    try {
      await fireaseauthRepository.firebaseInitAuth(
          phonenumber: phonenumber, context: context);
      emit(
          state.copyWith(autthstatus: Autthstatus.loading, numer: phonenumber));
    } on CustomError catch (e) {
      emit(state.copyWith(autthstatus: Autthstatus.error, customError: e));
    }
  }

  void verifyotp(
      {required String smscode,
      context,
      String? verificationid,
      required bool status}) async {
    emit(state.copyWith(autthstatus: Autthstatus.loading));
    try {
      await fireaseauthRepository.verifyOtp(
          smsCode: smscode,
          context: context,
          verificationid: verificationid ?? "",
          status: status);
      emit(state.copyWith(
        autthstatus: Autthstatus.loaded,
        smscode: smscode,
        verifystatus: true,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(autthstatus: Autthstatus.error, customError: e));
    }
  }
}
