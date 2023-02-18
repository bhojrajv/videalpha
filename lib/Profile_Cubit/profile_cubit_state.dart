// part of 'profile_cubit_cubit.dart';

// abstract class ProfileCubitState extends Equatable {
//   const ProfileCubitState();

//   @override
//   List<Object> get props => [];
// }

// class ProfileCubitInitial extends ProfileCubitState {}

import 'package:equatable/equatable.dart';

import '../customerror.dart';
import '../model/user_model.dart';

enum Profilestatus { initial, loaded, loading, error }

class ProfileState extends Equatable {
  final Profilestatus profilestatus;
  final CustomError customError;
  final User user;
  ProfileState({
    required this.profilestatus,
    required this.customError,
    required this.user,
  });

  factory ProfileState.initial() {
    return ProfileState(
        profilestatus: Profilestatus.initial,
        customError: CustomError(),
        user: User.initial());
  }

  ProfileState copyWith({
    Profilestatus? profilestatus,
    CustomError? customError,
    User? user,
  }) {
    return ProfileState(
      profilestatus: profilestatus ?? this.profilestatus,
      customError: customError ?? this.customError,
      user: user ?? this.user,
    );
  }

  @override
  String toString() =>
      'ProfileState(profilestatus: $profilestatus, customError: $customError, user: $user)';

  @override
  // TODO: implement props
  List<Object?> get props => [profilestatus, user, customError];
}
