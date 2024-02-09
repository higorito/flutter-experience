import 'package:fe_clinicas_core/fe_clinicas_core.dart';

abstract interface class IPainelRepository {
  Future<Either<RepositoryEx, String>> callOnPanel(
      String password, int attendantDesk);
}
