import 'package:procontact/data/model/contact.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'apiservice.g.dart';


@RestApi(baseUrl: 'https://647871a4362560649a2dc7b1.mockapi.io/api/')
abstract class apiService{
 factory apiService(Dio dio)=_apiService;

@GET('')
Future <List<Contact>> getContact();

@POST('')
Future <Contact> addContact(@Body() Contact contact);

@PUT('{id}')
Future <Contact> editContact(@Path("id") String id,@Body() Contact contact);

@DELETE('{id}')
Future <Contact> deleteContact(@Path("id") String id);
}