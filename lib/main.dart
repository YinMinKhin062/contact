import 'package:flutter/material.dart';
import 'package:procontact/bloc/get/cubit/getcontact_cubit.dart';
import 'package:procontact/module.dart';
import 'package:procontact/screen/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  locator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<GetcontactCubit>(
        create: (context) => getit.call(),
        child: Home(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
