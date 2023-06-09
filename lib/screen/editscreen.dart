import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procontact/bloc/add/cubit/addcontact_cubit.dart';
import 'package:procontact/bloc/get/cubit/getcontact_cubit.dart';
import 'package:procontact/bloc/update/cubit/editcontact_cubit.dart';
import 'package:procontact/data/model/contact.dart';
import 'package:procontact/module.dart';

class editScreen extends StatelessWidget {
 final Contact contact;

   editScreen(this.contact);


  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditcontactCubit>(
      create: (context) =>EditcontactCubit(getit.call()),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Edit Contact",style: TextStyle(fontSize: 14),),
          ),
          body: BlocBuilder<EditcontactCubit, EditcontactState>(
            builder: (context, state) {
              if(state is EditcontactLoading){
                return Center(child: CircularProgressIndicator());
              }
             else if(state is EditcontactSuccess){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Success"),
                      TextButton(onPressed: (){
                        Navigator.pop(context,'success');
                      }, child:Text( "home")),
                    ],
                  ),
                );
              }
              else if(state is EditcontactFail){
                Center(child: Text(state.error));
              }
              return contactForm(this.contact);
            },
          ),
        ),
    );
  }
}
class contactForm extends StatefulWidget {
  final Contact contact;

  const contactForm(this.contact);
  

  @override
  State<contactForm> createState() => _contactFormState(contact);
}

class _contactFormState extends State<contactForm> {
  final Contact contact;
  
  final _formkey=GlobalKey<FormState>();
  String ? _name,_phoneno,_note;

  _contactFormState(this.contact);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            initialValue: contact.phoneno,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:"Enter phone no" ,
              
            ),
            style: TextStyle(fontSize: 10),
            validator: (value) {
              if(value!.isEmpty){
                  return "Please Enter phoneno";
              }
              return null;
            },
            onSaved: (newValue) {
              _phoneno=newValue;
            },

          ),
          SizedBox(height: 20,),
          TextFormField(
            initialValue: contact.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:"Enter name" ,
              
            ),
            style: TextStyle(fontSize: 10),
            validator: (value) {
              if(value!.isEmpty){
                  return "Please Enter name";
              }
              return null;
            },
            onSaved: (newValue) {
              _name=newValue;
            },

          ),
          SizedBox(height: 20,),
          TextFormField(
            initialValue: contact.note,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:"Enter note" ,
              
            ),
            style: TextStyle(fontSize: 10),
            // validator: (value) {
            //   if(value!.isEmpty){
            //       return "Please Enter phoneno";
            //   }
            //   return null;
            // },
            onSaved: (newValue) {
              _note=newValue;
            },

          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            if(_formkey.currentState!.validate()){
              _formkey.currentState!.save();
              Contact c=new Contact(contact.id, _name, _phoneno, _note);
              // print('${c.id} ${c.name} ${c.note} ${c.phoneno}');
              BlocProvider.of<EditcontactCubit>(context).editContact(contact.id!,c);
            }
          }, child: Text("Edit"))

        ],
      ),);
  }
}