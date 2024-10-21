import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:color_selector/screens/catalog.dart';
import 'package:color_selector/screens/addlist.dart';
import 'package:color_selector/models/catalog.dart';
import 'package:color_selector/models/addlist.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

// Windows,Linux,MacOSのデスクトップ環境で実行される場合のウィンドウの設定
const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

// ルーティングの設定
GoRouter router() {
  return GoRouter(
    // アプリ起動後、最初に表示されるページ
    initialLocation: '/catalog',
    routes: [
      // ルートの定義
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: '/addlist',
            builder: (context, state) => const MyAddList(),
          ),
        ],
      ),
    ],
  );
}

// 色についての状態管理と選択した色に関する状態管理を行うためにMultiProviderを用いる
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // CatalogModelのインスタンスを作成し、アプリケーション全体でこのモデルを使用できるようにする
        Provider(create: (context) => CatalogModel()),
        // AddListModelを提供し、かつCatalogModelに依存することを示すために使用される
        ChangeNotifierProxyProvider<CatalogModel, AddListModel>(
          // AddListModelのインスタンスを作成するための関数
          create: (context) => AddListModel(),
          // CatalogModelが変更されたときに呼び出され、現在のAddListModelを更新するために使用される
          update: (context, catalog, addlist) {
            if (addlist == null) throw ArgumentError.notNull('addlist');
            addlist.catalog = catalog;
            return addlist;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'color-selecter',
        routerConfig: router(),
      ),
    );
  }
}
