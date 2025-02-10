import 'package:cubit_with_states_db/cubit/note_cubit_db.dart';
import 'package:cubit_with_states_db/cubit/note_state_db.dart';
import 'package:cubit_with_states_db/note_model_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class AddNotePage extends StatelessWidget {
  String? pageTitle;
  String? bTitle;
  bool update;
  DbModel? data;


  void updateControllers(){
   if(data!=null){
     titleController.text=data!.title;
     descController.text=data!.desc;
   }
  }


  AddNotePage({this.pageTitle,this.bTitle,required this.update,this.data});
  var titleController=TextEditingController();
  var descController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    updateControllers();
    return Scaffold(

      appBar: AppBar(title: Text(pageTitle ?? "ADD"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(pageTitle ??"Add Note"),
          TextField(controller:titleController ,),
          TextField(controller:descController ,),
          ElevatedButton(onPressed: (){
            if(update){
              context.read<NoteCubit>().updateNote(DbModel(note_id: data!.note_id,title: titleController.text.toString(),
                  desc: descController.text.toString()));
            }else {
              context.read<NoteCubit>().AddNote(
                  DbModel(title: titleController.text.toString(),
                      desc: descController.text.toString()));
            }

            titleController.clear();
            descController.clear();
            Navigator.pop(context);
          },
              child: Text(bTitle ?? "ADD"))
        ],
      ),

    );
  }
}
