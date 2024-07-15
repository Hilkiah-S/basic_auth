// import 'package:dartz/dartz.dart';
// import 'package:flutter/foundation.dart';
// import 'package:logger/logger.dart';
// import 'package:nanoq_merchant/core/constants/api_config.dart';
// import 'package:nanoq_merchant/core/constants/app_constants.dart';
// import 'package:nanoq_merchant/core/constants/button_constants.dart';
// import 'package:nanoq_merchant/core/services/dio_service.dart';
// import 'package:nanoq_merchant/core/shared/state/button_provider.dart';
// import 'package:nanoq_merchant/core/utils/error/api_failure.dart';
// import 'package:nanoq_merchant/core/utils/typedef.dart';
// import 'package:nanoq_merchant/features/authentication/data/login_response.dart';

// class AuthenticationProvider with ChangeNotifier {
//   ButtonProvider buttonProvider;

//   LoginResponse? _loginResponse;

//   String? _mobileNumber;

//   LoginResponse? get loginResponse => _loginResponse;

//   String? get mobileNumber => _mobileNumber;

//   set loginResponse(LoginResponse? value) {
//     _loginResponse = value;
//   }

//   set mobileNumber(String? value) {
//     _mobileNumber = value;
//   }

//   AuthenticationProvider({required this.buttonProvider});

//   // TODO: Load user phone number

//   FutureResult<bool> authenticateUser({
//     required String mobileNumber,
//     required String password,
//   }) async {
//     try {
//       buttonProvider.setButtonState(
//         ButtonConstants.loginButton,
//         ButtonState.loading,
//       );

//       _mobileNumber = mobileNumber;

//       // do the dio call
//       final authenticateUserResponse = await DioService.post(
//         isFormUrl: true,
//         path: APIConfig.loginPath,
//         data: {
//           "scope": AppConstants.scope,
//           "client_id": mobileNumber,
//           "client_secret": password,
//           "grant_type": "LOGIN",
//         },
//       );

//       return authenticateUserResponse.fold(
//         (l) {
//           buttonProvider.setButtonState(
//             ButtonConstants.loginButton,
//             ButtonState.active,
//           );

//           return Left(ApiFailure(message: l.message));
//         },
//         (response) {
//           // check status code
//           if (response['statusCode'] != null) {
//             if (response['statusCode'] != "0000") {
//               buttonProvider.setButtonState(
//                 ButtonConstants.loginButton,
//                 ButtonState.active,
//               );

//               return Left(
//                 ApiFailure(
//                   message: response["message"] as String,
//                 ),
//               );
//             }
//           }

//           try {
//             // cast response
//             loginResponse = LoginResponse.fromMap(response);

//             // reset button state
//             buttonProvider.setButtonState(
//               ButtonConstants.loginButton,
//               ButtonState.active,
//             );

//             // TODO: store phone number locally
//             // TODO: fetch phone on auth view and set it on form field

//             // return something
//             return const Right(true);
//           } catch (e) {
//             Logger().e(e);

//             buttonProvider.setButtonState(
//               ButtonConstants.loginButton,
//               ButtonState.active,
//             );

//             return Left(ApiFailure(message: e.toString()));
//           }
//         },
//       );
//     } catch (e) {
//       Logger().e(e);

//       buttonProvider.setButtonState(
//         ButtonConstants.loginButton,
//         ButtonState.active,
//       );

//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
// }
