import 'package:equatable/equatable.dart';

class CryptoCurrency extends Equatable {
  final String name;
  final String fullName;
  final double price;

  const CryptoCurrency({
    required this.name,
    required this.fullName,
    required this.price,
  });

  @override
  List<Object?> get props => [name, fullName, price];

  factory CryptoCurrency.fromMap(Map<String, dynamic> map) {
    return CryptoCurrency(
      name: map['CoinInfo']?['Name'] ?? '',
      fullName: map['CoinInfo']?['FullName'] ?? '',
      price: (map['RAW']?['USD']?['PRICE'] ?? 0).toDouble(),
    );
  }
}
