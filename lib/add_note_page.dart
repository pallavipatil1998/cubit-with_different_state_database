import 'package:cubit_with_states_db/cubit/note_cubit_db.dart';
import 'package:cubit_with_states_db/note_model_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotePage extends StatelessWidget {
  String? title;
  String? desc;
  int? note_id;
  bool isupdate=false;

  //class constructor
  AddNotePage({required this.isupdate,this.title,this.desc,this.note_id});


  var titleController=TextEditingController();
  var descController=TextEditingController();
  String operationTitle="ADD NOTE";


  addNote(String title,String desc,BuildContext context){
    context.read<NoteCubit>().AddNote(DbModel(title: title, desc: desc));
  }

  updateNote(String title,String desc,int note_id,BuildContext context){
    context.read<NoteCubit>().updateNote(DbModel(title: title, desc: desc,note_id: note_id));
  }


  void controllers(){
    if(title!=null && desc!= null){
      titleController.text=title!;
      descController.text=desc!;
    }
  }


  @override
  Widget build(BuildContext context) {
    if(isupdate){
      controllers();
      operationTitle="UPDATE NOTE";
    }
    return Scaffold(

      appBar: AppBar(title: Text(operationTitle),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(operationTitle),
          TextField(controller:titleController ,keyboardType: TextInputType.name,),
          TextField(controller:descController ,),
          ElevatedButton(onPressed: (){
            var mTitle=titleController.text.toString();
            var mDesc=descController.text.toString();
            if(isupdate){
              updateNote(mTitle, mDesc,note_id!, context);
            }else {
              addNote(mTitle, mDesc, context);
            }

            titleController.clear();
            descController.clear();
            Navigator.pop(context);
          },
              child: Text(operationTitle))
        ],
      ),

    );
  }
}
