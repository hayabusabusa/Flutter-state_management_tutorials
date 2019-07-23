import 'package:flutter/widgets.dart';

// MARK: App Keys
// テストの際に確認したいWdgetを取り出すためのキー？
// 初期化の時のKeyをこれにしてアクセスするのかも

class FlutterTodosKeys {
  static final extraActionsPopupMenuButton = 
    const Key('__extraActionsPopupMenuButton__');
  static final extraActionsEmptyContainer = 
    const Key('__extraActionsEmptyContainer__');
  static final filteredTodosEmptyContainer = 
    const Key('__filteredTodosEmptyContainer__');
  static final statsLoadingIndicator = const Key('__statsLoadingIndicator__');
  static final emptyStatsContainer = const Key('__emptyStatsContainer__');
  static final emptyDetailsContainer = const Key('__emptyDetailsContainer__');
  static final detailsScreenCheckBox = const Key('__detailScreenCheckBox__');
}