import 'package:dw_barbershop/src/core/constants/local_storage_keys.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';

import 'package:dw_barbershop/src/core/fp/either.dart';

import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/respositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;
  
  // ignore: prefer_typing_uninitialized_variables
  var userLoginService;
  
 UserLoginServiceImpl({
    required this.userRepository,
    required this.userLoginService,
  });
  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();

        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);

      case Failure(:final exception):
        return switch (exception) {
          AuthError() =>
            Failure(ServiceException(message: 'Erro ao realizar login')),
          AuthUnauthorizedException() =>
            Failure(ServiceException(message: 'Login ou senha inválidos')),
        };
    }
  }
}
