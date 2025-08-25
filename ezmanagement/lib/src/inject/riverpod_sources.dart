import 'package:ezmanagement/src/data/sources/key_source.dart';
import 'package:ezmanagement/src/data/sources/share_preference_key_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_sources.g.dart';

@riverpod
KeySource keySource(Ref ref) {
  ref.keepAlive();
  return SharePreferenceKeySource();
}
