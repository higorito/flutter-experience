import 'package:fe_clinicas_painel/src/models/painel_checkin_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract interface class IPainelCheckinRepository {
  ({WebSocketChannel channel, Function dispose}) openChannelSocket();

  Stream<List<PainelCheckinModel>> getTodayPainel(WebSocketChannel channel);
}
