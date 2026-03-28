import 'package:bank_system/core/utils/date_helper.dart';

extension RangeValidation on num {
  bool isBetween(num from, num to) {
    num minVal = from < to ? from : to;
    num maxVal = from > to ? from : to;
    return this >= minVal && this <= maxVal;
  }
}

extension NumberToWords on int {
  static const _units = [
    '', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine',
    'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen',
    'Seventeen', 'Eighteen', 'Nineteen'
  ];

  static const _tens = [
    '', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'
  ];

  static const _scales = {
    1000000000: 'Billion',
    1000000: 'Million',
    1000: 'Thousand',
    100: 'Hundred',
  };

  String toText() {
    if (this == 0) return "Zero";
    if (this < 0) return "Minus ${(this.abs()).toText()}";
    
    return _convert(this).trim();
  }

  String _convert(int n) {
    if (n == 0) return '';

    if (n < 20) return '${_units[n]} ';

    if (n < 100) {
      return '${_tens[n ~/ 10]} ${_convert(n % 10)}';
    }

    for (var entry in _scales.entries) {
      if (n >= entry.key) {
        return '${_convert(n ~/ entry.key)}${entry.value} ${_convert(n % entry.key)}';
      }
    }

    return '';
  }
}
