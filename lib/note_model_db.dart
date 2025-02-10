
import 'note_database.dart';

class DbModel{
  int? note_id;
  String title;
  String desc;

  DbModel({
    this.note_id,
    required this.title,
    required this.desc
  });



  factory DbModel.fromMap(Map<String,dynamic> map){
    return DbModel(
        note_id:map[AppDB.DB_COLUMN_NOTE_ID] ,
        title: map[AppDB.DB_COLUMN_TITLE],
        desc: map[AppDB.DB_COLUMN_DESC]
    );
  }



  Map<String,dynamic> toMap(){
    return{
      AppDB.DB_COLUMN_NOTE_ID:note_id,
      AppDB.DB_COLUMN_TITLE:title,
      AppDB.DB_COLUMN_DESC:desc

    };
  }



}