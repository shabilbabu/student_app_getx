import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../screen/db/models/dart_models.dart';

class MyController extends GetxController{

MyController(){
  getAllstudent();
  }
  
List<StudentModel> studentlist = <StudentModel> [];

List<StudentModel> temp = [];


Future <void> addstudent(StudentModel value)async
{
final  studentDB= await Hive.openBox<StudentModel>('student_db');
 final _id = await studentDB.add(value);
 value.id =_id;
 await studentDB.put(value.id, value); 
 studentlist.add(value);
 update();
}


Future<void>getAllstudent()async{
 final  studentDB = await Hive.openBox<StudentModel>('student_db'); 
 studentlist.clear();
 studentlist.addAll(studentDB.values);
 update();
} 

Future<void>deleteStudent(int id)async{
 final  studentDB = await Hive.openBox<StudentModel>('student_db');
 studentDB.delete(id);
 await getAllstudent();
 update();
}

Future<void>updatestudent(int id,StudentModel studentupvalue )async{
final  studentDB = await Hive.openBox<StudentModel>('student_db');
await  studentDB.put(id,studentupvalue);
await getAllstudent();
}

}