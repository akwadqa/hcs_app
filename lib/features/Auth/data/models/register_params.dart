import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String name;
  final String mobileNo;
  final String email;
  final String pass;
  final bool action;
  final String? businessName;
  final String? crNumber;

  const RegisterParams(
      {required this.name,
      required this.mobileNo,
      required this.email,
      required this.pass,
      required this.action,
      required this.businessName,
      required this.crNumber});

  @override
  List<Object?> get props =>
      [name, mobileNo, email, pass, action, businessName, crNumber];
}
