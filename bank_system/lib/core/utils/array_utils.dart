import 'package:bank_system/core/utils/random_utils.dart';

extension ListActions<T> on List<T> {
  void shuffleCustom() {
    for (int i = 0; i < length; i++) {
      int index1 = Util.randomNumber(0, length - 1);
      int index2 = Util.randomNumber(0, length - 1);
      
      T temp = this[index1];
      this[index1] = this[index2];
      this[index2] = temp;
    }
  }
}