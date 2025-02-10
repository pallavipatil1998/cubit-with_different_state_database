
import '../note_model_db.dart';

abstract class  NoteState{}

class NoteInitialState extends NoteState{}

class NoteLoadingState extends NoteState{}


class NoteLoadedState extends NoteState{
  List<DbModel> modelList=[];
  NoteLoadedState({ required this.modelList});
}


class NoteErrorSttate extends NoteState{
  String errorMsg="";
  NoteErrorSttate({required this.errorMsg});
}