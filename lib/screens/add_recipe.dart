import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_memo/helper/user_data.dart';
import 'package:recipe_memo/screens/top.dart';
import 'package:recipe_memo/utilities/constants.dart';
import 'package:recipe_memo/model/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_memo/screens/add_ingredient.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_memo/utilities/color.dart';
import 'package:recipe_memo/firebase/upload_file.dart';

class addRecipePage extends StatefulWidget {
  const addRecipePage({Key? key}) : super(key: key);

  @override
  _addRecipePageState createState() => _addRecipePageState();
}

class _addRecipePageState extends State<addRecipePage> {
  File? _image;
  final imagePicker = ImagePicker();
  Future getImageFromCamera() async {
    // final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future geiImageFromGallery() async {
    // final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // // final picker = ImagePicker();
  final Widget noImage_svg =
      SvgPicture.asset('assets/images/default_image.svg');

  final Recipe recipeData = Recipe(
    title: '',
    image_path: '',
    ingredients: [],
    description: '',
    user_id: currentUserId(),
    storage_path: '',
    created_at: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "新規作成",
          style: kAppBarTextStyle,
        ),
        backgroundColor: Color(lightThemeColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: _image == null
                      ? Image.asset('assets/images/default_image.jpg')
                      : Image.file(_image!),
                  onTap: () {
                    geiImageFromGallery();
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: kContentsTitlePadding,
                      width: kWidthDoubleInfinity,
                      decoration: const BoxDecoration(
                        border: kContentsTitleBorder,
                      ),
                      child: const Text(
                        'タイトル',
                        style: kContentsTitle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          enabledBorder: kOutlineInputBorder,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: Color(0xFFD6E4EC),
                            ),
                          ),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: '料理名が入ります',
                          // fillColor: Colors.black,
                        ),
                        onChanged: (text) {
                          recipeData.title = text;
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: kContentsTitlePadding,
                        width: kWidthDoubleInfinity,
                        decoration: const BoxDecoration(
                          border: kContentsTitleBorder,
                        ),
                        child: const Text(
                          '材料',
                          style: kContentsTitle,
                        ),
                      ),
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = recipeData.ingredients;
                          // var quantity = data[index].quantity;
                          return Container(
                            key: Key(data![index]['id']),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFD6E4EC)),
                              ),
                            ),
                            child: ListTile(
                              leading: Text(data[index]['title']),
                              title: Text(data[index]['quantity']),
                              trailing: const Icon(Icons.drag_handle),
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          );
                        },
                        itemCount: recipeData.ingredients!.length,
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final item =
                                recipeData.ingredients!.removeAt(oldIndex);
                            recipeData.ingredients!.insert(newIndex, item);
                          });
                        },
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: recipeData.ingredients?.length,
                      //   itemBuilder: (context, index) {
                      //     final data = recipeData.ingredients;
                      //     // final data = ingredientList[index];
                      //     return Container(
                      //       decoration: new BoxDecoration(
                      //         border: new Border(
                      //           bottom:
                      //               new BorderSide(color: Color(0xFFD6E4EC)),
                      //         ),
                      //       ),
                      //       child: ListTile(
                      //         leading: Text(data![index].title),
                      //         title: Text(data![index].quantity),
                      //         // leading: Text('11'),
                      //         // title: Text('aa'),
                      //         trailing: Icon(Icons.drag_handle),
                      //         contentPadding: EdgeInsets.all(0),
                      //       ),
                      //     );
                      //   },
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          height: 44,
                          width: kWidthDoubleInfinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(lightThemeColor),
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddIngredientPage()));

                              setState(() {
                                if (result != null) {
                                  recipeData.ingredients!.add(result);
                                }
                              });
                            },
                            child: const Text(
                              '材料追加',
                              style: kBtnText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Container(
                        padding: kContentsTitlePadding,
                        width: kWidthDoubleInfinity,
                        decoration: BoxDecoration(
                          border: kContentsTitleBorder,
                        ),
                        child: Text(
                          '作り方',
                          style: kContentsTitle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: kOutlineInputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Color(0xFFD6E4EC),
                              ),
                            ),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: 10,
                          onChanged: (text) {
                            recipeData.description = text;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 44,
                    width: kWidthDoubleInfinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(lightThemeColor),
                      ),
                      onPressed: () async {
                        // 画像をFirebase Storageに保存
                        if (_image != null) {
                          recipeData.image_path = _image.toString();
                          var result = await FirebaseStorage.instance
                              .ref()
                              .child('images')
                              .child(currentUserId())
                              .child(recipeData.title +
                                  recipeData.created_at.toString())
                              .putFile(_image!);
                          recipeData.storage_path = result.ref.fullPath;
                        }

                        await FirebaseFirestore.instance
                            .collection('recipe')
                            .doc()
                            .set(recipeData.toMap());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopPage(
                                      title: '',
                                    )));
                      },
                      child: const Text(
                        '作成',
                        style: kBtnText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
