import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Rapsody of Fire', votes: 5),
    Band(id: '3', name: 'Arch enemy', votes: 5),
    Band(id: '4', name: 'Dimmu Borgir', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        // ignore: prefer_const_constructors
        title: Text(
          'Band Names',
          // ignore: prefer_const_constructors
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adddNewBand,
        elevation: 1,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {},
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete Band',
              style: TextStyle(color: Colors.white),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue,
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  adddNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('New band Name'),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () => addBandToList(textController.text),
                    child: Text('Add'),
                    textColor: Colors.blue,
                    elevation: 5,
                  )
                ],
              ));
    }
    //is IOS
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('New band Name'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: () => addBandToList(textController.text),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dissmiss'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
