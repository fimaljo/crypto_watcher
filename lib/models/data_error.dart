import 'package:equatable/equatable.dart';

class DataError extends Equatable {
  final String message;

  const DataError({this.message = ''});

  @override
  List<Object?> get props => [message];
}
