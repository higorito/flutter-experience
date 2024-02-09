import 'dart:typed_data';

import 'package:fe_clinicas_core/fe_clinicas_core.dart';

abstract class IDocumentsRepository {
  Future<Either<RepositoryEx, String>> uploadFile(
      Uint8List file, String fileName);
}
