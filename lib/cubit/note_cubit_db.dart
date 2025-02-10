import 'package:cubit_with_states_db/cubit/note_state_db.dart';
import 'package:cubit_with_states_db/note_model_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../note_database.dart';

class NoteCubit extends Cubit<NoteState>{
  AppDB db;

  //1
  NoteCubit({required this.db}):super(NoteInitialState());


  //DB Methods

  //2

   void AddNote(DbModel note)async{
    emit(NoteLoadingState());

    bool check= await db.addNote(note);
    if(check){
      var notes=await db.fetchAllNotes();
      emit(NoteLoadedState(modelList: notes));
    }else{
      emit(NoteErrorSttate(errorMsg: "Error: Note Not Added"));
    }

  }

  void getInitialNotes()async{
     var allNotes=await db.fetchAllNotes();
     emit(NoteLoadedState(modelList: allNotes));
  }


  void deleteNote(int id)async{
     emit(NoteLoadingState());
     bool check=await db.deleteNote(id);
     if(check){
       var notes=await db.fetchAllNotes();
       emit(NoteLoadedState(modelList:notes));
     }else{
       emit(NoteErrorSttate(errorMsg:"Database Error: Data Not Deleted" ));
     }
  }


  void updateNote( DbModel model)async{
     emit(NoteLoadingState());
     bool check=await db.updateNote(model);
     print(check);
     if(check){
       var note=await db.fetchAllNotes();
       emit(NoteLoadedState(modelList: note));
     }else{
       emit(NoteErrorSttate(errorMsg: "Database Error: Data not Updated"));
     }
  }



}