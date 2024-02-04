import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/repositories/user/user_repository.dart';
import 'package:fe_clinicas_self_service/src/services/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements IUserLoginService {
  final IUserRepository userRepository;

  UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceEx, Unit>> execute(String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthErrorEx(message: final message)):
        return Left(ServiceEx(message: 'Erro ao fazer login: $message'));
      case Left(value: AuthUnauthorizedEx()):
        return Left(ServiceEx(message: 'Usuário ou senha inválidos'));
      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConsts.acessToken, accessToken);
        return Right(unit);
    }
  }
}
