import 'package:flutter/foundation.dart';
import 'package:color_selector/models/catalog.dart';

// ChangeNotifierを継承しているため、このクラスは状態が変更されたことをリスナーに通知できる
class AddListModel extends ChangeNotifier {
  // 現在のカタログを保持できるプライベート変数で、CatalogModel型
  late CatalogModel _catalog;
  // AddList内のアイテムIDを保持するリスト
  final List<int> _itemIds = [];

  // カタログ内のゲッターでカタログを取得する
  CatalogModel get catalog => _catalog;

  // セッターにて新しいカタログを設定し、カタログが変更されたことをリスナーに通知する
  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    notifyListeners();
  }

  // AddList内のアイテムのリスト
  // _itemIdsに格納されたIDを基に、現在のカタログからアイテムを取得し、リストとして返す
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  // アイテムの追加
  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  // アイテムの削除
  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
