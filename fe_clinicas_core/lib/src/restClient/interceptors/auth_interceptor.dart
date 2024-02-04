import 'package:dio/dio.dart';
import 'package:fe_clinicas_core/src/consts/local_storage_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

//basicamente um interceptor é um middleware que intercepta a requisição e a resposta
//e pode fazer alguma coisa com elas, necessario para adicionar o token de autenticação JWT
final class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) =
        options; //essa linha é um destructuring de options, parecido com o que é feito em javascript no props de um objeto

    const authHeaderKey = 'Authorization';
    headers.remove(
        authHeaderKey); //remove o header de autenticação caso exista(mapa entao posso usar o metodo remove)

    if (extra case {'AUTH_KEY': true}) {
      //vamos usar o shared preferences p persistir o token de autenticação
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageConsts.acessToken)}',
      });
    }
    handler.next(options);

    super.onRequest(options, handler);
  }
}
