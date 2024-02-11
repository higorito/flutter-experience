library fe_clinicas_core;

export 'src/fp/either.dart';
export 'src/fp/nil.dart';
export 'src/fp/unit.dart';

export 'src/helpers/messages.dart';
export 'src/consts/local_storage_consts.dart';

export 'src/clinicas_core_config.dart';

export 'src/exceptions/auth_ex.dart';
export 'src/exceptions/repository_ex.dart';
export 'src/exceptions/service_ex.dart';

export 'src/theme/clinicas_theme.dart';
export 'src/widgets/clinicas_appbar.dart';
export 'src/widgets/icon_popup_menu.dart';

//export condicional
export 'src/restClient/rest_client.dart'
    if (dart.library.html) 'src/restClient/rest_client_web.dart';
