import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/getx%20/mycontroller.dart';
import 'db/models/dart_models.dart';
import 'db/models/details.dart';



class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  // get  studentDeatails_screen => null;

  MyController mycontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(),
      body: bodysearch(context),
    );
  }
  bar() {

    return AppBar(
      title: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular((30)),
        ),
        child: TextField(
          onTap: () {},
          onChanged: (String? value) {
            if (value == null ||value.isEmpty) {
              mycontroller.temp.addAll(mycontroller.studentlist);
              
            } else {
              mycontroller.temp.clear();
              for (StudentModel i in mycontroller.studentlist) {
                if (i.name.toLowerCase().contains(value.toLowerCase())) {
                  mycontroller.temp.add(i);
                }
                
              }
            }
          },
          controller: searchController,
          decoration: const InputDecoration(
            
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            prefixIcon: Icon(Icons.search,),
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintText: 'search',
            hintStyle: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

  bodysearch(BuildContext context) {
    return SafeArea(
        child: GetBuilder<MyController>(
            
            builder: (controller) {
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = mycontroller.temp[index];
                    return ListTile(
                        title: Text(data.name),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => Details(
                              name: data.name,
                              age: data.age,
                              guardion: data.guardion,
                              number: data.number,
                              image: data.image!,
                            ),
                          ));
                        });
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: mycontroller.temp.length);
            }));
  }
}
