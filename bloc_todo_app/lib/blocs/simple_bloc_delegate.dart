import 'package:bloc/bloc.dart';

// MARK: Bloc Delegate

/// Simple Bloc Delegate
/// 
/// Blocの全てのStateの変化を一箇所でまとめてハンドリングできるようにするためのDelegate。
/// ログやエラーの分析などに便利。
/// Googleアナリティクスに接続できるらしい(すごい)
class SimpleBlocDelegate extends BlocDelegate {

  // Eventが流れた時
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  // Stateが新しいStateに変化した時
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}