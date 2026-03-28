import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/data_access/services.dart';
import 'package:bank_system/models/bank_client_model_pro.dart';

class ClientRepos {
  static const String _fileName = clientFileName;

  static List<BankClientModelPro> loadClients() {
    final lines = Services.loadLinesFromFile(_fileName);
    return lines
        .map((line) => BankClientModelPro.fromLine(line))
        .where((client) => !client.getIsEmpty)
        .toList();
  }

  static void saveClients(List<BankClientModelPro> clients) {
    final lines = clients.map((client) => client.toLine()).toList();
    Services.saveAllLinesToFile(_fileName, lines);
  }

  static void addClient(BankClientModelPro client) {
    Services.addLineToFile(client.toLine(), _fileName);
  }

  static void updateClient(BankClientModelPro client) {
    final lines = Services.loadLinesFromFile(_fileName);
    final index = lines.indexWhere(
      (line) => line.contains(client.accountNumber),
    );
    if (index != -1) {
      lines[index] = client.toLine();
      Services.saveAllLinesToFile(_fileName, lines);
    }
  }
}
