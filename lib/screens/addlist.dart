import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_selector/models/addlist.dart';

class MyAddList extends StatelessWidget {
  const MyAddList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Color Add List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(32),
              child: _MyListItem(),
            )),
          ],
        ),
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var addList = context.watch<AddListModel>();
    return ListView.builder(
      itemCount: addList.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Container(
          width: 24.0,
          height: 24.0,
          color: addList.items[index].color,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            addList.remove(addList.items[index]);
          },
        ),
        title: Text(
          addList.items[index].name,
        ),
      ),
    );
  }
}
