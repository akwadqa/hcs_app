// import 'package:dio/dio.dart';
// import 'package:hcs/src/di/services_locator.dart';
// import 'package:hcs/src/error/exceptions.dart';
// import 'package:hcs/src/network/error_massage_model.dart';

// class ApiService {
//   static final Dio dio = sl<Dio>();

//   static Future<Response> get(String path) async {
//     try {
//       final response = await dio.get(path);
//       return response;
//     } catch (error) {
//       throw ServerException(
//           errorMassage: ErrorMassage.fromJson(const {'status': 0}));
//     }
//   }

//   static Future<Response> post(String path, [Object? data]) async {
//     try {
//       final response = await dio.post(path, data: data);
//       print("the res${response.data}");

//       return response;
//     } catch (error) {
//       throw ServerException(
//           errorMassage: ErrorMassage.fromJson(const {'status': 0}));
//     }
//   }

//   static Future<Response> patch(String path, [Object? data]) async {
//     try {
//       final response = await dio.patch(path, data: data);
//       return response;
//     } catch (error) {
//       throw ServerException(
//           errorMassage: ErrorMassage.fromJson(const {'status': 0}));
//     }
//   }

//   static Future<Response> put(String path, [Object? data]) async {
//     try {
//       final response = await dio.put(path, data: data);
//       return response;
//     } catch (error) {
//       throw ServerException(
//           errorMassage: ErrorMassage.fromJson(const {'status': 0}));
//     }
//   }

//   static Future<Response> delete(String path, [Object? data]) async {
//     try {
//       final response = await dio.delete(path, data: data);
//       return response;
//     } catch (error) {
//       throw ServerException(
//           errorMassage: ErrorMassage.fromJson(const {'status': 0}));
//     }
//   }

//   static dynamic handleError(error) {
//     // Implement your error handling logic here
//     return error;
//   }
// }
