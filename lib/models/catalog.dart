// 色を扱うデータモデル

import 'package:flutter/material.dart';

class CatalogModel {
  // 色の名前定義(カタログとしての色の名前を管理する)
  static List<String> itemNames = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Orange',
    'Purple',
    'Pink',
    'Brown',
    'Black',
    'White',
    'Gray',
    'Cyan',
    'Magenta',
    'Indigo',
    'Violet',
    'Gold',
    'Silver',
    'Turquoise',
    'Beige',
    'Lavender',
  ];

  // idに基づいてアイテムを取得
  // 引数idで指定された番号を使って、Itemを取得する
  // 例えば、idが5の場合、このメソッドは5番目の色(purple)に対応するItemオブジェクトを返す
  Item getById(int id) => Item(id, itemNames[id]);

  Item getByPosition(int position) {
    return getById(position);
  }
}

// このクラスが不変なことを示している
@immutable
// 1つの色アイテム(名前と色)を表す不変のデータ構造(色の名前に基づいて実際の色(Color)をマッピングする)
class Item {
  final int id;
  final String name;
  final Color color;

  // 色名とColorのマッピング
  // 色の名前(String)を実際のColorクラスに対応づけるマップ
  static final Map<String, Color> colorMap = {
    'Red': Colors.red,
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Yellow': Colors.yellow,
    'Orange': Colors.orange,
    'Purple': Colors.purple,
    'Pink': Colors.pink,
    'Brown': Colors.brown,
    'Black': Colors.black,
    'White': Colors.white,
    'Gray': Colors.grey,
    'Cyan': Colors.cyan,
    'Magenta': Colors.pinkAccent,
    'Indigo': Colors.indigo,
    'Violet': Colors.deepPurple,
    'Gold': Colors.amber,
    'Silver': Colors.blueGrey,
    'Turquoise': Colors.teal,
    'Beige': Colors.brown[300]!, // カスタムカラー
    'Lavender': Colors.purpleAccent,
  };

  // イニシャライザリストによるコンストラクタ
  /*
  例えば、getById(0)を呼び出した場合、
  Item(0, itemName[0])は、Item(0, 'Red')になる
  Itemクラスのコンストラクタにより、color = colorMap['Red']が自動的にセットされる
  */
  Item(this.id, this.name) : color = colorMap[name]!; // 色名に基づいて色を取得
}
