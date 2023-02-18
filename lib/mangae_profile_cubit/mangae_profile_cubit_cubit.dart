import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:videalpha/customerror.dart';
import 'package:videalpha/firebaseAuthRepository/profile_repository.dart';

part 'mangae_profile_cubit_state.dart';

class MangaeProfileCubitCubit extends Cubit<ManageProfileCubit> {
  final ProfileRepository profileRepository;
  final BuildContext? context;
  MangaeProfileCubitCubit({required this.profileRepository, this.context})
      : super((ManageProfileCubit.intial()));

  FutureOr<void> mangeprofile(
      {required String name,
      required String email,
      required String age,
      required String dob,
      required String contact,
      context}) async {
    try {
      emit(state.copyWith(manageProfilestatus: ManageProfilestatus.submitting));
      await profileRepository.manageProfile(
          name: name,
          email: email,
          age: age,
          dob: dob,
          contact: contact,
          context: context);
      emit(state.copyWith(manageProfilestatus: ManageProfilestatus.submitting));
    } on CustomError catch (e) {
      emit(state.copyWith(
          manageProfilestatus: ManageProfilestatus.error,
          customError:
              CustomError(code: e.code, messg: e.messg, plugin: e.plugin)));
    } catch (e) {
      emit(state.copyWith(
          manageProfilestatus: ManageProfilestatus.error,
          customError: CustomError(
              code: e.toString(), messg: e.toString(), plugin: e.toString())));
    }
  }
}
