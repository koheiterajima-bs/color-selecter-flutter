# color_selector

A new Flutter project.

## やったこと
- 色についての状態管理と選択した色に関する状態管理の2つが必要
- models/catalog.dartにて、色は有限個にし、リストに順番に格納されていくようにしたい→完
- screens/catalog.dartにて、20個の色が順番に表示されるようにしたい→完
- models/addlist.dartにて、選択した色のみを選択したい→完
- screens/addlist.dartにて、選択した色のみが表示されるようにしたい→完

## できないこと
- なぜかボタンを押しても、ボタンが無効にならない、、(screens/catalog.dart)
```dart
    // これはtrueになるが、
    onPressed: isInAdd
        ? null
        : () {
            var addList = context.read<AddListModel>();
            addList.add(item);
        },
    
    // これはtrueにならない、、
    child: isInAdd
        ? const Icon(Icons.check, semanticLabel: 'ADDED')
        : const Text('ADD'),
```


