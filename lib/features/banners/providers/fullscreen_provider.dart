import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fullscreen_provider.g.dart';

@riverpod
class Fullscreen extends _$Fullscreen {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
    _notify();
  }

  void set(bool fullscreen) {
    state = fullscreen;
    _notify();
  }

  void _notify() {
    // if (state) {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // } else {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // }
  }
}
