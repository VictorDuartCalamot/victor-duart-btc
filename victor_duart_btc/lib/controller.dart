import 'dart:ffi';

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

  Tarea(this.dataOrdre,this.open,this.max,this.min,this.close,this.volume);

  Id id = Isar.autoIncrement;
   final DateTime? dataOrdre;
   final float? open;
   final float? max;
   final float? min;
   final float? close;
   final Int? volume;


}



