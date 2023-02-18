import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videalpha/Approute/Approuting.dart';
import 'package:videalpha/customerror.dart';
import 'package:videalpha/mangae_profile_cubit/mangae_profile_cubit_cubit.dart';

import '../constant/db_constant.dart';
import '../model/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<User> getprofile({required String uid}) async {
    try {
      DocumentSnapshot documentSnapshot = await userRef.doc(uid).get();
      if (documentSnapshot.exists) {
        final currentuser = User.fromdoc(documentSnapshot);
        return currentuser;
      }
      throw "User not found";
    } on FirebaseException catch (e) {
      throw CustomError(messg: e.message!, code: e.code, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: "Exception",
          messg: e.toString(),
          plugin: "firebae-server/exception");
    }
  }

  FutureOr<void> manageProfile(
      {required String name,
      required String email,
      required String age,
      required String dob,
      required String contact,
      context}) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    try {
      users.add({
        "name": name,
        "email": email,
        "age": age,
        "dob": dob,
        "contact": contact
      }).then((value) {
        Navigator.pushNamed(context, Nameroute.userProfile);
        const snackbr = SnackBar(
          content: Text("User Created Successfully"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbr);
        BlocProvider.of<MangaeProfileCubitCubit>(context).emit(
            ManageProfileCubit(
                customError: CustomError(),
                manageProfilestatus: ManageProfilestatus.submitted));
      });
    } on CustomError catch (e) {
      throw CustomError(code: e.code, messg: e.messg, plugin: e.plugin);
    } catch (e) {
      debugPrint("errorOnaddeduser:$e");
      const snackbr = SnackBar(
        content: Text("something went wrong"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbr);
    }
  }
}
