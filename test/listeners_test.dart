import 'package:contract/contract.dart' as c;
import 'package:contract/listeners.dart';
import 'package:test/test.dart';

void main() {
  test('do not throw when "shouldThrow" is set to false', () {
    Listeners.shouldThrow = false;
    void clause() => c.Contract.clause(1, 2);
    expect(clause, returnsNormally);
  });

  test('throw "ContractClauseBroken" when "shouldThrow" is set to true', () {
    Listeners.shouldThrow = true;
    void clause() => c.Contract.clause(1, 2);
    expect(clause, throwsA(isA<c.ContractClauseBroken>()));
  });

  test('init should change Listeners.verbose value', () {
    expect(c.Contract.verbose, true);
    c.Contract.init(verbose: false);
    expect(c.Contract.verbose, false);
  });

  test('init should change Listeners.shouldThrow value', () {
    expect(c.Contract.shouldThrow, true);
    c.Contract.init(shouldThrow: false);
    expect(c.Contract.shouldThrow, false);
  });
}
