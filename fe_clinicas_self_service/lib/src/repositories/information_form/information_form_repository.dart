import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_self_service/src/model/self_service_model.dart';

abstract interface class IInformationFormRepository {
  Future<Either<RepositoryEx, Unit>> register(SelfServiceModel model);
}
