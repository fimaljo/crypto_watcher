import 'dart:convert';
import 'package:crypto_app/models/currency.dart';
import 'package:crypto_app/models/data_error.dart';
import 'package:http/http.dart' as http;

class CryptoRepository {
  static const String _baseUrl = 'https://min-api.cryptocompare.com/';

  final http.Client _httpClient;

  CryptoRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<CryptoCurrency>> getCurrencies() async {
    const requestUrl =
        '${_baseUrl}data/top/totalvolfull?limit=25&tsym=USD&page=0';
    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final coinList = List.from(data['Data']);
        return coinList.map((e) => CryptoCurrency.fromMap(e)).toList();
      }
      return [];
    } catch (err) {
      throw DataError(message: err.toString());
    }
  }
}
