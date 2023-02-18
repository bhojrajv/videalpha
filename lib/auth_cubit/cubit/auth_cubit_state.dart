part of 'auth_cubit_cubit.dart';

// abstract class AuthCubitState extends Equatable {
//   const AuthCubitState();

//   @override
//   List<Object> get props => [];
// }

// class AuthCubitInitial extends AuthCubitState {}

enum Autthstatus { initial, loading, loaded, error }

class AuthcubitState extends Equatable {
  final CustomError customError;
  final Autthstatus autthstatus;
  String verficationid = "";
  bool verifystatus = false;
  String smscode = "";
  String number = "";
  AuthcubitState(
      {required this.customError,
      required this.autthstatus,
      this.verficationid = "",
      this.smscode = "",
      this.verifystatus = false,
      this.number = ""});

  factory AuthcubitState.initial() {
    return AuthcubitState(
        customError: CustomError(),
        autthstatus: Autthstatus.initial,
        smscode: "",
        verficationid: "",
        verifystatus: false,
        number: "");
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [customError, autthstatus, smscode, verficationid, verifystatus];

  AuthcubitState copyWith(
      {CustomError? customError,
      Autthstatus? autthstatus,
      String? verficationid,
      String? smscode,
      bool? verifystatus,
      String? numer}) {
    return AuthcubitState(
        customError: customError ?? this.customError,
        autthstatus: autthstatus ?? this.autthstatus,
        verficationid: verficationid ?? this.verficationid,
        smscode: smscode ?? this.smscode,
        verifystatus: verifystatus ?? this.verifystatus,
        number: number ?? this.number);
  }

  @override
  String toString() {
    return 'AuthcubitState(customError: $customError, autthstatus: $autthstatus, verficationid: $verficationid, smscode: $smscode,verifystatus:$verifystatus,number:$number)';
  }
}
