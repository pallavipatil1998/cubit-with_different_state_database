import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'note_model_db.dart';

class AppDB{

  AppDB._();
  static final AppDB db=AppDB._();
  Database? _database;

  static final DB_TABLE="db_note";
  static final DB_COLUMN_NOTE_ID="note_id";
  static final DB_COLUMN_TITLE="title";
  static final DB_COLUMN_DESC="desc";



  Future<Database> getDb()async{
    if(_database!=null){
      return _database!;
    }else{
      _database=await initDb();
      return _database!;
    }
  }


  Future<Database> initDb()async {
    Directory documentDirectory=await getApplicationDocumentsDirectory();
    var dbPath=join(documentDirectory.path,"noteDB.db");

    return openDatabase(
        dbPath,
        version: 1,
        onCreate: (db,version){
          db.execute("create table $DB_TABLE($DB_COLUMN_NOTE_ID integer primary key autoincrement,$DB_COLUMN_TITLE text,$DB_COLUMN_DESC)");
        }
    );



  }

  Future<bool> addNote(DbModel model)async{
    var d=await getDb();
    int rowsAdded=await d.insert(DB_TABLE,model.toMap());
    return rowsAdded>0;
  }


  Future<bool> updateNote(DbModel model)async{
    var d=await getDb();
    print("NOTE_ID: ${model.note_id}");
    int rowsUpdated=await d.update(DB_TABLE,model.toMap(),where:"$DB_COLUMN_NOTE_ID = ${model.note_id}" );
    return rowsUpdated>0;
  }


 /* Future<bool> updateNote(DbModel model)async{
    var d=await getDb();

    int rowsUpdated=await d.update(DB_TABLE,model.toMap(),where:"$DB_COLUMN_NOTE_ID = ${model.note_id}" );
    return rowsUpdated>0;
  }*/

  Future<bool> deleteNote(int id)async{
    var d=await getDb();
    int rowsDeleted=await d.delete(DB_TABLE,where:"$DB_COLUMN_NOTE_ID=?",whereArgs: [id]);
    return rowsDeleted>0;
  }

  Future<List<DbModel>> fetchAllNotes()async{
    var d=await getDb();
    List<DbModel> modelList=[];
    List<Map<String,dynamic>> noteList=await d.query(DB_TABLE);
    for(Map<String,dynamic> note in noteList){
      DbModel model= DbModel.fromMap(note);
      modelList.add(model);
    }

    return modelList;

  }



}