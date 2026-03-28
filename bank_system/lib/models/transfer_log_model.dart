class TransferLogModel {
  final String dateTime;
  final String senderAccNumber;
  final String receiverAccNumber;
  final num transferAmount;
  final num senderAmountAfter;
  final num receiverAmountAfter;
  final String transferUser;

  TransferLogModel({
    required this.dateTime,
    required this.senderAccNumber,
    required this.receiverAccNumber,
    required this.transferAmount,
    required this.senderAmountAfter,
    required this.receiverAmountAfter,
    required this.transferUser,
  });

  factory TransferLogModel.fromLine(String line, {String sep = "#//#"}) {
    List<String> data = line.split(sep);
    return TransferLogModel(
      dateTime: data[0].trim(),
      senderAccNumber: data[1].trim(),
      receiverAccNumber: data[2].trim(),
      transferAmount: num.parse(data[3].trim()),
      senderAmountAfter: num.parse(data[4].trim()),
      receiverAmountAfter: num.parse(data[5].trim()),
      transferUser: data[6].trim(),
    );
  }
  String toLine({String sep = "#//#"}) {
    return [
      dateTime,
      senderAccNumber,
      receiverAccNumber,
      transferAmount,
      senderAmountAfter,
      receiverAmountAfter,
      transferUser,
    ].map((e) => e.toString()).join(sep);
  }
}
