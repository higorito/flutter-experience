import 'package:fe_clinicas_core/fe_clinicas_core.dart';

abstract interface class IDeskAssignmentRepository {
  Future<Either<RepositoryEx, Unit>> startService(int deskNumber);

  Future<Either<RepositoryEx, int>> getDeskAssignment();
}
