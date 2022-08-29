import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/getx%20/mycontroller.dart';
import 'package:students/screen/db/models/details.dart';
import 'package:students/screen/search_screen.dart';
import 'package:students/screen/submit_screen.dart';
import 'db/models/edit.dart';

class Home_Screen extends StatelessWidget {
   Home_Screen({Key? key}) : super(key: key);
  MyController mycontroller = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Students Detailes',
          style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontFamily: 'colonnamt'),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.to(SearchBar());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: GetBuilder<MyController>(
        
        builder:  ((controller) 
          
        {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = controller.studentlist;
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                        
                        textColor: Colors.white,
                        title: Text(
                          data[index].name,
                          style: const TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w700,),
                        ),
                        subtitle: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  if (data[index].id != null) {
                                    await controller.deleteStudent(data[index].id !);
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => Edit(
                                            name: data[index].name,
                                            age: data[index].age,
                                            guardion: data[index].guardion,
                                            number: data[index].number,
                                            id: data[index].id,
                                            image: data[index].image!,
                                          )));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )),
                          ],
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: MemoryImage(
                            const  Base64Decoder().convert(data[index].image.toString())),
                          maxRadius: 30,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => Details(
                              name: data[index].name,
                              age: data[index].age,
                              guardion: data[index].guardion,
                              number: data[index].number,
                              image: data[index].image!,
                            ),
                          ));
                        }),

                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider(
                  height: 4,
                );
              },
              itemCount: controller.studentlist.length);
        }
      )),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => Submitscreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
