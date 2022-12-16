import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:victor_duart_btc/model.dart';
import 'controller.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TareaSchema],
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> createTask(Tarea ntarea) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.tareas.putSync(ntarea));
  }

  Stream<List<Tarea>> getAllTareas() async* {
    final isar = await db;
    yield* isar.tareas.where().watch(fireImmediately: true);
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());

  }

}
/*

abstract class ModeloFisicoInterfaz {
  int deleteTarea(Tarea tarea);
  int anadirTarea(Tarea tarea);
}

class ModeloFisicaIsar extends ModeloFisicoInterfaz {
  @override
  int anadirTarea(Tarea tarea) {
    // TODO: implement anadirTarea
    throw UnimplementedError();
  }

  @override
  int deleteTarea(Tarea tarea) {
    // TODO: implement deleteTarea
    throw UnimplementedError();
  }
}
*/
