import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'model.dart';
import 'main.dart';
part 'controller.g.dart';


class Controller{

    List<Widget> getWidgetList(List<Widget> lista) {

        return lista;
    }

//Getter de la lista del modelo
  List<String> getTasks() {
    return Model().todoList;
  }

  void addTask(String task){
    //Model() nos da acceso a funciones del Modelo
    Model().addTask(task);
  }

}

@collection
class Tarea {

  Tarea(this.titulo);

  Id id = Isar.autoIncrement;
   final String? titulo;

}



