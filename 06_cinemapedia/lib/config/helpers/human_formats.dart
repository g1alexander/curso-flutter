import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HumanFormats {
  static Future<void> initialize() async {
    await initializeDateFormatting('es_ES', null);
  }

  static String number(double number, [int decimals = 0]) {
    final formatterNumber = NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: '', locale: 'en')
        .format(number);

    return formatterNumber;
  }

  static String date(DateTime nowDate) {
    final formatter = DateFormat('EEEE d', 'es_ES');
    final formattedDate = formatter.format(nowDate);

    return toBeginningOfSentenceCase(formattedDate);
  }
}
