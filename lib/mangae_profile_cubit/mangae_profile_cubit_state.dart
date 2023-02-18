part of 'mangae_profile_cubit_cubit.dart';

// abstract class MangaeProfileCubitState extends Equatable {
//   const MangaeProfileCubitState();

//   @override
//   List<Object> get props => [];
// }

// class MangaeProfileCubitInitial extends MangaeProfileCubitState {}

enum ManageProfilestatus { initial, submitting, submitted, error }

class ManageProfileCubit extends Equatable {
  final CustomError customError;
  final ManageProfilestatus manageProfilestatus;
  String name = "";
  String age = "0";
  String dob = "";
  String email = "";
  ManageProfileCubit(
      {required this.customError,
      this.name = "",
      this.age = "",
      this.dob = "",
      this.email = "",
      required this.manageProfilestatus});

  factory ManageProfileCubit.intial() {
    return ManageProfileCubit(
        customError: CustomError(),
        age: "",
        dob: "",
        email: "",
        name: "",
        manageProfilestatus: ManageProfilestatus.initial);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [name, age, dob, email, customError, manageProfilestatus];

  ManageProfileCubit copyWith(
      {CustomError? customError,
      String? name,
      String? age,
      String? dob,
      String? email,
      ManageProfilestatus? manageProfilestatus}) {
    return ManageProfileCubit(
        customError: customError ?? this.customError,
        name: name ?? this.name,
        age: age ?? this.age,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        manageProfilestatus: manageProfilestatus ?? this.manageProfilestatus);
  }

  @override
  String toString() {
    return 'ManageProfileCubit(customError: $customError, name: $name, age: $age, dob: $dob, email: $email,manageProfilestatus:$manageProfilestatus)';
  }
}
