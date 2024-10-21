import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:color_selector/models/addlist.dart';
import 'package:color_selector/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          // 通常のSizedBoxをスライバーに変換する
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          // リスト形式で要素を表示するためのスライバー
          SliverList(
            // 必要に応じてアイテムを遅延生成するためのもの
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < 20) {
                  return _MyListItem(index);
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Color Catalog',
          style: TextStyle(
            color: Colors.white,
          )),
      backgroundColor: Colors.brown,
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.dehaze_sharp, color: Colors.white),
          onPressed: () => context.go('/catalog/addlist'),
        ),
      ],
    );
  }
}

// addListに追加ボタン
class _AddButton extends StatelessWidget {
  final Item item;

  // インスタンス作成時にitemを渡す必要がある
  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    // context.select()：特定の状態(この場合、カートの中にアイテムがあるかどうか)を選択し、監視する
    var isInAdd = context.select<AddListModel, bool>(
      (addList) => addList.items.contains(item),
    );

    return TextButton(
      onPressed: isInAdd
          ? null
          : () {
              var addList = context.read<AddListModel>();
              addList.add(item);
            },
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null;
        }),
      ),
      child: isInAdd
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

class _MyListItem extends StatelessWidget {
  // 表示させる番号のindexを設定
  final int index;

  // indexに基づいてカタログから対応するアイテムを表示する
  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    // context.selectを使って、CatalogModelからItemを取得する
    var item = context.select<CatalogModel, Item>(
      (catalog) => catalog.getByPosition(index),
    );

    // ここでitemを確認
    print('Item at index $index: ${item.name}, ID: ${item.id}');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
