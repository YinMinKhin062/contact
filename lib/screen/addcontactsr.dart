import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procontact/bloc/add/cubit/addcontact_cubit.dart';
import 'package:procontact/bloc/get/cubit/getcontact_cubit.dart';
import 'package:procontact/data/model/contact.dart';
import 'package:procontact/module.dart';

class addContactSr extends StatelessWidget {
  const addContactSr({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddcontactCubit>(
      create: (context) =>AddcontactCubit(getit.call()),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add Contact",style: TextStyle(fontSize: 14),),
          ),
          body: BlocBuilder<AddcontactCubit, AddcontactState>(
            builder: (context, state) {
              if(state is AddcontactLoading){
                return Center(child: CircularProgressIndicator());
              }
             else if(state is AddcontactSuccess){
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
              else if(state is AddcontactFail){
                Center(child: Text(state.error));
              }
              return contactForm();
            },
          ),
        ),
    );
  }
}
class contactForm extends StatefulWidget {
  const contactForm({super.key});

  @override
  State<contactForm> createState() => _contactFormState();
}

class _contactFormState extends State<contactForm> {
  final _formkey=GlobalKey<FormState>();
  String ? _name,_phoneno,_note;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
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
              Contact c=new Contact('', _name, _phoneno, _note);
              BlocProvider.of<AddcontactCubit>(context).addContact(c);
            }
          }, child: Text("Add"))

        ],
      ),);
  }
}