import 'package:cubit_with_states_db/add_note_page.dart';
import 'package:cubit_with_states_db/cubit/note_cubit_db.dart';
import 'package:cubit_with_states_db/cubit/note_state_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();

}



class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NoteCubit>().getInitialNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOME PAGE"),),
      body: BlocBuilder<NoteCubit,NoteState>(builder: (_,state){
        if(state is NoteLoadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(state is NoteErrorSttate){
          return Text(state.errorMsg);
        }else if(state is NoteLoadedState){
          return ListView.builder(
            itemCount: state.modelList.length,
              itemBuilder: (ctx,index){
              var currData=state.modelList[index];
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>AddNotePage(isupdate: true,title: currData.title,desc: currData.desc,note_id: currData.note_id,),));

              },
              child: ListTile(
                leading: Text("${index+1}"),
                title:Text(state.modelList[index].title) ,
                subtitle:Text(state.modelList[index].desc) ,
                trailing:InkWell(
                  onTap: (){
                    context.read<NoteCubit>().deleteNote(state.modelList[index].note_id!);
                  },
                    child: Icon(Icons.delete)) ,
              ),
            );
          });
        }
        return Center(child: Container(child: Text("No Data Found"),));
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(isupdate: false),));
      },
      child: Icon(Icons.navigate_next_rounded),),
    );
  }
}
