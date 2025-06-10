import 'package:equatable/equatable.dart';

class AddCustomerParams extends Equatable {
  final String? customerType;
  final String? customerName;
  final String? customerQid;
  final String? customerPhone;

  const AddCustomerParams({
    required this.customerType,
    required this.customerName,
    required this.customerQid,
    required this.customerPhone,
  });

  @override
  List<Object?> get props => [
    customerType,
    customerName,
    customerQid,
    customerPhone,
  ];
}
