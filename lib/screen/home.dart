import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:procontact/bloc/get/cubit/getcontact_cubit.dart';
import 'package:procontact/data/model/contact.dart';
import 'package:procontact/screen/addcontactsr.dart';
import 'package:procontact/screen/editscreen.dart';

final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetcontactCubit>(context).getContact();
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Contact List of procontact",style: TextStyle(fontSize: 14),),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
      var result= await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => addContactSr(),));
          if( result!=null && result =='success'){
            BlocProvider.of<GetcontactCubit>(context).getContact();
           
          }

        },),
      body:BlocBuilder<GetcontactCubit, GetcontactState>(
        builder: (context, state) {
          if(state is GetcontactSuccess){
            List<Contact> cLists=state.contacts;
            return ListView.builder(
              itemCount: cLists.length,
              itemBuilder: (context, index) {
              return item(cLists[index]);
              },);
          }
          else if(state is GetcontactFail){
            return Text(state.error);
          }
          return Center(child: CircularProgressIndicator());
        },
      ) ,
    );
  }

Widget item(Contact contact){
  return Slidable(
    endActionPane: ActionPane(
      motion: ScrollMotion(),
      children: [
        SlidableAction(onPressed: (context) async{
      var res=await Navigator.push(context,
           MaterialPageRoute(builder: (context) => editScreen(contact),));
           
           if(res!=null && res=='success'){
            BlocProvider.of<GetcontactCubit>(_globalKey.currentContext!).getContact();
           }
        },
        icon: Icons.edit,
        backgroundColor: Colors.blue,
        ),
        SlidableAction(onPressed: (context) {
          BlocProvider.of<GetcontactCubit>(context).deleteContact(contact.id!);
        },
        icon: Icons.delete,
        backgroundColor: Colors.red,
        )
      ]),
    child: Card(
      child: ListTile(
        leading: Icon(Icons.person),
      title: Text(contact.phoneno!,style: TextStyle(fontSize: 12),),
      subtitle: Text(contact.name!,style: TextStyle(fontSize: 12),),
      trailing: Text(contact.note!,style: TextStyle(fontSize: 12),),
    
      ),
    ),
  );
}
}