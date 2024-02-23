abstract class Listeners {
  static bool verbose = true;
  static List<void Function(Object, StackTrace?)> listeners = [];

  /// Set [verbose] mode true or false
  ///
  /// When set to true, a not null StackTrace will be provide for all listeners.
  static void setVerbose(bool verbose) => verbose = verbose;

  /// Add [listener] callback to be called whenever a [softClause] is broken
  static void add(void Function(Object, StackTrace?) listener) =>
      listeners.add(listener);

  /// Remove [listener] from callback listeners list
  static void remove(void Function() listener) => listeners.remove(listener);

  static void dispose() {
    listeners = [];
  }

  /// Notify all listeners
  static void notify(Object e) {
    final stackTrace = verbose ? StackTrace.current : null;
    for (var listenerCallback in listeners) {
      listenerCallback(e, stackTrace);
    }
  }
}
