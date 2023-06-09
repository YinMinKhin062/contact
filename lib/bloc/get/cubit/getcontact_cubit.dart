import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procontact/data/api/apiservice.dart';
import 'package:procontact/data/contactrepo.dart';
import 'package:procontact/data/model/contact.dart';

part 'getcontact_state.dart';

class GetcontactCubit extends Cubit<GetcontactState> {

final contactRepo cr;

  GetcontactCubit(this.cr) : super(GetcontactInitial());

  void getContact(){
    emit(GetcontactInitial());
    cr.getContact().then((value) => emit(GetcontactSuccess(value)))
    .catchError((e)=>emit(GetcontactFail(e)));
  }

  void deleteContact(String id){
    cr.deleteContact(id).then((value) => getContact())
    .catchError((e)=>emit(GetcontactFail(e)));

  }
}
