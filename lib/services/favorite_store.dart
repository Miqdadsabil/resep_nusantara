import 'package:flutter/foundation.dart';

/// Penyimpanan favorit sederhana (in-memory) memakai ValueNotifier.
class FavoriteStore {
  FavoriteStore._();
  static final ValueNotifier<Set<int>> ids = ValueNotifier<Set<int>>({});

  static void toggle(int id) {
    final next = {...ids.value};
    next.contains(id) ? next.remove(id) : next.add(id);
    ids.value = next;
  }
}