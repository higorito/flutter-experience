import 'package:fe_clinicas_core/fe_clinicas_core.dart';

abstract interface class IUserLoginService {
  Future<Either<ServiceEx, Unit>> execute(String email, String password);
}
