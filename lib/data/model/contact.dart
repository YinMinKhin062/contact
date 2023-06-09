
import 'package:json_annotation/json_annotation.dart';
part 'contact.g.dart';
@JsonSerializable()
class Contact{
  String? id,name,phoneno,note;
  Contact(this.id,this.name,this.phoneno,this.note);

  factory Contact.fromJson(Map<String,dynamic>json)=> _$ContactFromJson(json);
  Map<String,dynamic>toJson()=> _$ContactToJson(this);

}