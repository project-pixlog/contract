library;

import 'listeners.dart';
import 'src/expect/expect.dart' as e;

export 'src/core_matchers.dart';
export 'src/custom_matcher.dart';
export 'src/description.dart';
export 'src/equals_matcher.dart';
export 'src/error.dart';
export 'src/interfaces.dart';
export 'src/iterable_matchers.dart';
export 'src/map_matchers.dart';
export 'src/numeric_matchers.dart';
export 'src/operator_matchers.dart';
export 'src/order_matchers.dart';
export 'src/string_matchers.dart';
export 'src/type_matcher.dart';
export 'src/util.dart';

abstract class Contract {
  static bool get verbose => Listeners.verbose;

  /// Set [verbose] mode true or false
  ///
  /// When set to true, a not null StackTrace will be provided for listeners
  /// together with [reason].
  static void setVerbose(bool verbose) => Listeners.verbose = verbose;

  /// Add [listener] callback to be called whenever a [softClause] is broken
  static void addListener(void Function(Object, StackTrace?) listener) =>
      Listeners.add(listener);

  /// Remove [listener] from callback listeners list
  static void removeListener(void Function() listener) =>
      Listeners.remove(listener);

  static void dispose() => Listeners.dispose();

  /// Assert that [actual] matches [matcher].
  ///
  /// [matcher] can be a value in which case it will be wrapped in an
  /// [equals] matcher.
  ///
  /// If the assertion fails [reason] is send to [listeners].
  /// If [verbose] mode is on, StackTrace.current is send to [listeners] too.
  ///
  /// Certain matchers, like [completion] and [throwsA], either match or fail
  /// asynchronously. When you use [softClause] with these matchers, it ensures that
  /// the test doesn't complete until the matcher has either matched or failed. If
  /// you want to wait for the matcher to complete before continuing the test, you
  /// can call [asyncClause] instead and `await` the result.
  static void softClause(dynamic actual, dynamic matcher) =>
      e.expect(actual, matcher);

  /// Assert that [actual] matches [matcher]. Throws if don't.
  ///
  /// [matcher] can be a value in which case it will be wrapped in an
  /// [equals] matcher.
  ///
  /// If the assertion fails [reason] is send to [listeners].
  /// If [verbose] mode is on, StackTrace.current is send to [listeners] too.
  ///
  /// Certain matchers, like [completion] and [throwsA], either match or fail
  /// asynchronously. When you use [softClause] with these matchers, it ensures that
  /// the test doesn't complete until the matcher has either matched or failed. If
  /// you want to wait for the matcher to complete before continuing the test, you
  /// can call [asyncClause] instead and `await` the result.
  static void clause(dynamic actual, dynamic matcher) =>
      e.expect(actual, matcher);

  /// Just like [softClause], but returns a [Future] that completes when the matcher
  /// has finished matching.
  ///
  /// For the [completes] and [completion] matchers, as well as [throwsA] and
  /// related matchers when they're matched against a [Future], the returned
  /// future completes when the matched future completes. For the [prints]
  /// matcher, it completes when the future returned by the callback completes.
  /// Otherwise, it completes immediately.
  ///
  /// If the matcher fails asynchronously, that failure is piped to the returned
  /// future where it can be handled by user code.
  static Future asyncClause(dynamic actual, dynamic matcher) async =>
      e.expectLater(actual, matcher);
}
