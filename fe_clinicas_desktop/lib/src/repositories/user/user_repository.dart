import 'package:fe_clinicas_core/fe_clinicas_core.dart';

abstract interface class IUserRepository {
  Future<Either<AuthEx, String>> login(String email,
      String password); //ou retorna um erro ou um token de autenticação(string)
}
