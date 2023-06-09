import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:procontact/bloc/add/cubit/addcontact_cubit.dart';
import 'package:procontact/bloc/get/cubit/getcontact_cubit.dart';
import 'package:procontact/data/api/apiservice.dart';
import 'package:procontact/data/contactrepo.dart';


var getit=GetIt.I;
void locator(){

Dio dio=Dio();
getit.registerLazySingleton(() => dio);

apiService api=apiService(getit.call());
getit.registerLazySingleton(() => api);

contactRepo cr=contactRepo(getit.call());
getit.registerLazySingleton(() => cr);


GetcontactCubit cc=GetcontactCubit(getit.call());
getit.registerLazySingleton(() => cc);

AddcontactCubit ac=AddcontactCubit(getit.call());
getit.registerLazySingleton(() => ac);

}