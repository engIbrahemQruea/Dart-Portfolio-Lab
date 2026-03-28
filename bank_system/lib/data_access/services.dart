import 'dart:io';

import 'package:bank_system/core/utils/constance.dart';
import 'package:bank_system/models/bank_client_model_pro.dart';

class Services {
  static List<BankClientModelPro> loadDataFromFile() {
    final file = File(clientFileName);
    if (!file.existsSync()) return [];
    try {
      return file
          .readAsLinesSync()
          .where((line) => line.trim().isNotEmpty)
          .map((line) => BankClientModelPro.fromLine(line))
          .toList();
    } catch (e) {
      print('Error reading file: $e');
      return [];
    }
  }

  static void saveClientsDataToFile(List<BankClientModelPro> clients) {
    final file = File(clientFileName);
    final lines = clients.map((client) => client.toLine()).toList();
    file.writeAsStringSync(lines.join('\n'));
  }

  static void saveDataToFile(String lineData) {
    try {
      final file = File(clientFileName);

      file.writeAsStringSync('$lineData\n', mode: FileMode.append, flush: true);
    } catch (e) {
      stderr.writeln(
        'Critical Error: Could not save to $clientFileName. Details: $e',
      );
    }
  }

  static void addLineToFile(String lineData, String fileName) {
    try {
      final file = File(fileName);

      file.writeAsStringSync('$lineData\n', mode: FileMode.append, flush: true);
    } catch (e) {
      stderr.writeln(
        'Critical Error: Could not save to $fileName. Details: $e',
      );
    }
  }

  static List<String> loadLinesFromFile(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) return [];
    return file
        .readAsLinesSync()
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  static void saveAllLinesToFile(String filePath, List<String> lines) {
    final file = File(filePath);
    if (lines.isEmpty) {
      file.writeAsStringSync('');
    } else {
      file.writeAsStringSync(lines.join('\n') + '\n');
    }
  }


  // Static List<String> loadLinesFromFilee(String fileName) {
  //     final file = File(fileName);
  //     if (!file.existsSync()) return [];
  //     try {
  //       return file
  //           .readAsLinesSync()
  //           .where((line) => line.trim().isNotEmpty)
  //           .toList();
  //     } catch (e) {
  //       print('Error reading file: $e');
  //       return [];
  //     }
  //   }

  //   static List<BankClientModel> _loadDataFromFile() {
  //     final file = File(clientFileName);
  //     if (!file.existsSync()) return [];
  //     try {
  //       return file
  //           .readAsLinesSync()
  //           .where((line) => line.trim().isNotEmpty)
  //           .map((line) => BankClientModel._convertLineToBankClientModelObject(line))
  //           .toList();
  //     } catch (e) {
  //       print('Error reading file: $e');
  //       return [];
  //     }
  //   }

  //   static void _saveClientsDataToFile(List<BankClientModel> clients) {
  //     final file = File(clientFileName);
  //     final lines = clients
  //         .map(
  //           (client) =>
  //               BankClientModel._convertBankClientModelObjectToLine(client),
  //         )
  //         .toList();
  //     file.writeAsStringSync(lines.join('\n'));
  //   }

  //   static bool addNewClient(BankClientModel client) {
  //     if (BankClientModel.isClientExist(client.accountNumber)) {
  //       return false;
  //     }
  //     final clients = _loadDataFromFile();
  //     clients.add(client);
  //     _saveClientsDataToFile(clients);
  //     return true;
  //   }

  //   static bool deleteClient(String accountNumber) {
  //     final clients = _loadDataFromFile();
  //     final initialLength = clients.length;
  //     clients.removeWhere(
  //       (client) =>
  //           client.accountNumber.trim().toUpperCase() ==
  //           accountNumber.trim().toUpperCase(),
  //     );

  //     if (clients.length < initialLength) {
  //       _saveClientsDataToFile(clients);
  //       return true;
  //     }
  //     return false;
  //   }

  //   bool updateClient(BankClientModel updatedClient) {
  //     final List<BankClientModel> clients = BankClientModel._loadDataFromFile();
  //     for (int i = 0; i < clients.length; i++) {
  //       if (clients[i].accountNumber.trim().toUpperCase() ==
  //           updatedClient.accountNumber.trim().toUpperCase()) {
  //         clients[i] = updatedClient;
  //         _saveClientsDataToFile(clients);
  //         return true;
  //       }
  //     }
  //     return false;
  //   }

  //   static List<BankClientModel> getClientsList() {
  //     return _loadDataFromFile();
  //   }
}
