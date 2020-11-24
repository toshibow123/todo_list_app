import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Words extends Table {
  TextColumn get strToDo => text()();
  TextColumn get strDateandTime => text()();

  BoolColumn get isMemorized => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {strToDo};
}

@UseMoor(tables: [Words])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(_openConnection());

  @override
  int get schemaVersion => 2;

  //統合処理
  MigrationStrategy get migration => MigrationStrategy(
    onCreate:  (Migrator m){
      return m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1){
        await m.addColumn(words, words.isMemorized);
      }
    }
  );

  //CREATE
  Future addWord(Word word) => into(words).insert(word);

  //READ
  Future<List<Word>> get allWords => select(words).get();

  //UPDATE
  Future updateWord(Word word) => update(words).replace(word);

  //DELETE
  Future deleteWord(Word word) =>
      (delete(words)
        ..where((table) => table.strToDo.equals(word.strToDo)))
          .go();

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'words.db'));
    return VmDatabase(file);
  });
}