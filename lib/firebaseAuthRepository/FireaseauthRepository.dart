import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videalpha/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:videalpha/customerror.dart';

import '../Approute/Approuting.dart';

class FireaseauthRepository {
  final BuildContext? context;

  FirebaseAuth auth;
  FireaseauthRepository({this.context, required this.auth});
  firebaseInitAuth(
      {required String phonenumber, String? smsCode, context}) async {
    BlocProvider.of<AuthCubitCubit>(context, listen: false)
        .state
        .copyWith(numer: phonenumber);
    await auth
        .verifyPhoneNumber(
            timeout: const Duration(seconds: 120),
            phoneNumber: phonenumber,
            verificationCompleted:
                (PhoneAuthCredential phoneAuthCredential) async {
              debugPrint("verificationdone:${phoneAuthCredential.smsCode}");
              await auth.signInWithCredential(PhoneAuthProvider.credential(
                  verificationId: phoneAuthCredential.verificationId ?? "",
                  smsCode: phoneAuthCredential.smsCode ?? ""));
              Navigator.pushNamed(context!, Nameroute.manageprofile);
              if (phoneAuthCredential.smsCode != null) {
                //Navigator.pushNamed(context??BuildContext(), "otp");

              }
            },
            verificationFailed: verificationFailed,
            codeSent: (String verificationId, int? forceResendingToken) async {
              BlocProvider.of<AuthCubitCubit>(context, listen: false)
                  .emit(AuthcubitState(
                customError: CustomError(),
                autthstatus: Autthstatus.loaded,
                verficationid: verificationId,
                verifystatus: true,
              ));
              Navigator.pushNamed(context, Nameroute.otp, arguments: {
                "number":
                    BlocProvider.of<AuthCubitCubit>(context, listen: false)
                        .state
                        .number
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              debugPrint("codretrievalTimeout:${verificationId}");

              BlocProvider.of<AuthCubitCubit>(context, listen: false).emit(
                  AuthcubitState(
                      customError: CustomError(),
                      autthstatus: Autthstatus.loaded,
                      verifystatus: true,
                      verficationid: verificationId));
            })
        .then((value) => debugPrint("onsuccess:${"success"}"))
        .onError((error, stackTrace) {
      debugPrint("onerror:${error}");
    });
  }

  void verificationFailed(FirebaseAuthException error) {
    debugPrint("error:${error.message}");
  }

  Future<bool> verifyOtp(
      {required String smsCode,
      context,
      String? verificationid,
      required bool status}) async {
    debugPrint("optcode::${smsCode}/${verificationid}");
    debugPrint(
        "*****authvierifyid****${BlocProvider.of<AuthCubitCubit>(context, listen: false).state.verficationid}");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationid ?? "", smsCode: smsCode);
    BlocProvider.of<AuthCubitCubit>(context, listen: false).emit(AuthcubitState(
        customError: CustomError(),
        autthstatus: Autthstatus.loading,
        verifystatus: status));
    await auth.signInWithCredential(credential).then((value) {
      debugPrint("*****userProfile****$smsCode");
      Navigator.pushNamed(context, Nameroute.manageprofile);
      BlocProvider.of<AuthCubitCubit>(context, listen: false).emit(
          AuthcubitState(
              customError: CustomError(),
              autthstatus: Autthstatus.loaded,
              verifystatus: false));
    }).onError((error, stackTrace) {
      debugPrint("otpverify:${error}");
    });
    return BlocProvider.of<AuthCubitCubit>(context, listen: false)
        .state
        .verifystatus;
  }
}
