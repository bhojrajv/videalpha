import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String code;
  final String messg;
  final String plugin;
  CustomError({
    this.code = '',
    this.messg = '',
    this.plugin = '',
  });

  @override
  // TODO: implement props
  List<Object?> get props => [code, messg, plugin];

  @override
  String toString() =>
      'CustomError(code: $code, messg: $messg, plugin: $plugin)';

  CustomError copyWith({
    String? code,
    String? messg,
    String? plugin,
  }) {
    return CustomError(
      code: code ?? this.code,
      messg: messg ?? this.messg,
      plugin: plugin ?? this.plugin,
    );
  }
}
