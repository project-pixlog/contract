/// An exception thrown when a test assertion fails.
class ContractClauseBroken implements Exception {
  final String? message;

  ContractClauseBroken(this.message);

  @override
  String toString() => message.toString();
}
