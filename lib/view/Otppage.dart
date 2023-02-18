import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:videalpha/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:videalpha/firebaseAuthRepository/FireaseauthRepository.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String phonenumber = "";
  String smscode = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    var arg = ModalRoute.of(context)?.settings.arguments as Map;
    debugPrint('number:$arg["number"]');
    phonenumber = arg['number'] ?? "";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthcubitState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    outlineBorderRadius: 4.0,
                    otpFieldStyle: OtpFieldStyle(
                        borderColor: Colors.black54,
                        focusBorderColor: Colors.black54),
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                      setState(() {
                        smscode = pin;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FractionallySizedBox(
                    widthFactor: .8,
                    child: Container(
                      height: 40,
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: () {
                          if (smscode == "") {
                            debugPrint("please enter you otp");
                          } else {
                            debugPrint("smscode::${smscode}");
                            context.read<AuthCubitCubit>().verifyotp(
                                smscode: smscode,
                                context: context,
                                verificationid: state.verficationid,
                                status: true);
                          }
                        },
                        child: Text(
                          state.autthstatus == Autthstatus.loading
                              ? "Please Wait ...."
                              : "Verify OTP",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
