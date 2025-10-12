// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';

// class AppointmentState extends Equatable {
//   //Appointments
//   final int? currentAppointmentsPage;
//   final List<Appointment> ordersAppointments;
//   final RequestStates appointmentsStates;

//   final String? ordersMessage;

//   const AppointmentState({
//     //orders
//     this.ordersMessage = '',
//     //Orders Details

//     //Appointments
//     this.currentAppointmentsPage,
//     this.ordersAppointments = const [],
//     this.appointmentsStates = RequestStates.init,
//   });
//   AppointmentState copyWith({
//     int? currentAppointmentsPage,
//     List<Appointment>? ordersAppointments,
//     RequestStates? appointmentsStates,
//     String? ordersMessage,
//   }) {
//     return AppointmentState(
//       ordersMessage: ordersMessage ?? this.ordersMessage,
//       currentAppointmentsPage: currentAppointmentsPage,
//       ordersAppointments: ordersAppointments ?? this.ordersAppointments,
//       appointmentsStates: appointmentsStates ?? this.appointmentsStates,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     //orders
    
//     ordersMessage,

//     //Appointments
//     currentAppointmentsPage,
//     ordersAppointments,
//     appointmentsStates,

//   ];
// }
