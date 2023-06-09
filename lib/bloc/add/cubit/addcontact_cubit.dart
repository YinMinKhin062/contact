import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procontact/data/contactrepo.dart';
import 'package:procontact/data/model/contact.dart';

part 'addcontact_state.dart';

class AddcontactCubit extends Cubit<AddcontactState> {

final contactRepo cr;

  AddcontactCubit(this.cr) : super(AddcontactInitial());

  void addContact(Contact contact){
    emit(AddcontactLoading());
    cr.addContact(contact).then((value) => emit(AddcontactSuccess()))
    .catchError((e)=>emit(AddcontactFail(e)));

  }
}
