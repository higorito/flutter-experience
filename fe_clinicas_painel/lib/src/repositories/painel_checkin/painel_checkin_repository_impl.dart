import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fe_clinicas_core/fe_clinicas_core.dart';
import 'package:fe_clinicas_painel/src/core/env.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/painel_checkin_model.dart';
import 'painel_checkin_repository.dart';

import 'package:intl/intl.dart';

class PainelCheckinRepositoryImpl implements IPainelCheckinRepository {
  PainelCheckinRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;

  @override
  ({WebSocketChannel channel, Function dispose}) openChannelSocket() {
    //so vai avisar quando tiver atualizacao na tabela de painelCheckin
    final channel = WebSocketChannel.connect(
        Uri.parse('${Env.wsBackendBaseUrl}?tables=painelCheckin'));

    return (
      channel: channel,
      dispose: () {
        channel.sink.close();
      }
    );
  }

  @override
  Stream<List<PainelCheckinModel>> getTodayPainel(
      WebSocketChannel channel) async* {
    //vai usar generates, vai a todo momento mandar informacoes, no dart é o *
    yield await requestData();

    yield* channel.stream.asyncMap((_) async => requestData());
    //stream que manda informacoes para outra stream
  }

  Future<List<PainelCheckinModel>> requestData() async {
    final dateFormat = DateFormat('y-MM-dd');
    final Response(:List data) =
        await restClient.auth.get('/painelCheckin', queryParameters: {
      'time_called': dateFormat.format(DateTime.now()),
    });

    //inverter pq é do mais antigo para o mais novo, entao invertemos
    return data.reversed
        .take(7)
        .map((e) => PainelCheckinModel.fromJson(e))
        .toList();
  }
}
