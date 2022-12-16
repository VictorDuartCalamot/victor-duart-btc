import 'package:flutter/material.dart';
import 'controller.dart';
import 'package:path/path.dart' as p;
import 'package:isar/isar.dart';



class Model {
  //Constructor secundario que inicializa la clase
  static final Model _model = Model._internal();
  //Constructor por defecto
  factory Model() {
    return _model;
  }

  //Constructor Real
  Model._internal();

  final List<String> _todoList = <String>[
  
  ];



  void addTask(String task) {
    _todoList.add(task);
  }

  //Getter que devuelve la lista
  List<String> get todoList => _todoList;

//Otro tipo de getter
/*List<String> getTasks(){
    return _todoList;
  }*/

}






