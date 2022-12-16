
import 'package:flutter/material.dart';
import '/isar_service.dart';
import 'controller.dart';
import 'package:isar/isar.dart';

//Hola Carles la persistencia esta presente
// Se pinta al añadir pero al reiniciar no se pinta pero esta en la base de datos
//puedes acceder a la base de datos desde el link que sale en la consola (Solo abre con chromium)

void main() {

  runApp(Btc());

}

class Btc extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BtcList());
  }
}

//Pinta la lista de tareas
class BtcList extends StatefulWidget {
  BtcList({super.key});
  final isarService = IsarService();
  final Controller elControlador = Controller();
  @override
  _BtcListState createState() => _BtcListState();
}


//Referencia al Controlador


class _BtcListState extends State<BtcList> {
  final TextEditingController _textFieldController = TextEditingController();
  //Creo variable tipo Future<List<Widget>>
  late final Future<List<Widget>> _finalList;

  @override
  void initState() {
    //Meto los datos de _getItems() en la variable
   _finalList = _getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Ponemos el futureBuilder lo primero de todo,
                        //Indicamos el tipo de futurebuilder
    return FutureBuilder<List<Widget>>(
        future: _finalList,
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.hasData){}
          List<Widget> newlist = snapshot.data ?? [];
          return Scaffold(
            appBar: AppBar(title: const Text('BTC List')),
            body: ListView(children: _getListItems()),
            floatingActionButton:  Wrap( //will break to another line on overflow
                direction: Axis.horizontal, //use vertical to show  on vertical axis
                children: <Widget>[
            Container(
            margin:EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () => '',
                  //action code for button 1
                  tooltip: 'Delete Btc',
                child: Icon(Icons.delete),
              )
          ), //button first

          Container(
          margin:EdgeInsets.all(10),
          child: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
          )

              ],
            ),
          );


        },
    );
  }
  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      //widget es la referencia al padre StatefulWidget
      widget.elControlador.addTask(title);
    });
    _textFieldController.clear();
  }

  // this Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(title: Text(title));
  }

  // display a dialog for the user to enter items
  Future<dynamic> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter DATE/OPEN/HIGH/LOW/CLOSE/ADJ VOLUME/VOLUME'),
            ),
            actions: <Widget>[
              // add button
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.isarService.createTask(Tarea());
                  _addTodoItem(_textFieldController.text);
                },
              ),
              // Cancel button
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
  // iterates through our todo list title
  Future<List<Widget>> _getItems() async {
    await Future.delayed(Duration(seconds: 3));
    final List<Widget> _todoWidgets = <Widget>[];
                            //Usamos el getter creado en el controlador con ambas referencias (widget) y (elcontrolador)

    await for (var listaTareas in  widget.isarService.getAllTareas())
    //widget.elControlador.getTasks()
      {
        for (Tarea tarea in listaTareas) {
        _todoWidgets.add(_buildTodoItem(tarea.dataOrdre,tarea.open,tarea.max,tarea.min,tarea.close,tarea.volume));
      }
    }
    return _todoWidgets;
  }

  List<Widget> _getListItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    //Usamos el getter creado en el controlador con ambas referencias (widget) y (elcontrolador)
    for (String title in widget.elControlador.getTasks()) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }

}