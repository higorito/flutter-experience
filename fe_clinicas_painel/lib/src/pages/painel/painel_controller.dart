import 'package:fe_clinicas_painel/src/models/painel_checkin_model.dart';
import 'package:fe_clinicas_painel/src/repositories/painel_checkin/painel_checkin_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PainelCotroller {
  PainelCotroller({
    required IPainelCheckinRepository painelCheckinRepository,
  }) : _painelCheckinRepository = painelCheckinRepository;

  final IPainelCheckinRepository _painelCheckinRepository;

  Function? _socketDispose;

  //lista de signals
  final painelData = listSignal<PainelCheckinModel>([]);
  Connect? _painelConnect;

  Future<void> listenerPainel() async {
    final (:channel, :dispose) = _painelCheckinRepository.openChannelSocket();
    _socketDispose = dispose;

    //uma conexao que vai receber algo e quando receber vai atualizar a lista de signals
    _painelConnect = connect(painelData);

    final painelStream = _painelCheckinRepository.getTodayPainel(channel);
    _painelConnect!
        .from(painelStream); //conecta o gerenciador de estados com o stream
  }

  void dispose() {
    _painelConnect?.dispose();
    if (_socketDispose != null) {
      _socketDispose!();
    }
  }
}
