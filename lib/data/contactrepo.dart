import 'package:procontact/data/api/apiservice.dart';
import 'package:procontact/data/model/contact.dart';

class contactRepo{

final apiService api;

contactRepo(this.api);

Future <List<Contact>> getContact()=> api.getContact();

Future <Contact> addContact(Contact contact)=>api.addContact(contact);

Future <Contact> editContact(String id, Contact contact)=>api.editContact(id, contact);

Future <Contact> deleteContact(String id)=> api.deleteContact(id);

  
}