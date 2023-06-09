import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procontact/data/contactrepo.dart';
import 'package:procontact/data/model/contact.dart';

part 'editcontact_state.dart';

class EditcontactCubit extends Cubit<EditcontactState> {
  final contactRepo cr;
  EditcontactCubit(this.cr) : super(EditcontactInitial());

  void editContact(String id, Contact contact){
    emit(EditcontactLoading());
    cr.editContact(id, contact).then((value) => emit(EditcontactSuccess()))
    .catchError((e)=>emit(EditcontactFail(e)));
  }
}

