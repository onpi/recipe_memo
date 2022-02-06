import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_memo/model/recipe.dart';
import 'package:recipe_memo/model/recipe_data.dart';
import 'package:recipe_memo/service/auth.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Recipe> recipeList = [];

  RecipeListModel recipeListModel = RecipeListModel();
  final AuthService _auth = AuthService();

  void addRecipeList() async {
    var recipeItems = await recipeListModel.getResipe();
    recipeList = recipeItems;
    setState(() {});
  }

  Future<String> _get_image(String _image_path, String _storage_path) async {
    print('_get_image');
    print(_image_path);
    print(_storage_path);
    // 画像

    // Future<String> downloadURL =
    //     FirebaseStorage.instance.ref(_storage_path).getDownloadURL();
    // print(downloadURL);
    // Future<bool> existLocal = io.File(_image_path).exists();
    // print(existLocal);

    Widget _image;
    if (_image_path != 'null' && _image_path != null) {
      _image = Image.file(File(_image_path));
    }
    // image.file(_image!)
    if (_image_path != 'null' && _storage_path != 'null') {
      return 'assets/images/default_image.jpg';
      // SvgPicture.asset('assets/images/default_image.svg');
    }
    return 'assets/images/default_image.jpg';
  }

  Future<String> _getimg() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference imageRef = storage.ref(
        "images/Kq0dxqUQ90YukU57eLwpXMGPp1F2/aa2022-01-30 17:21:16.731589");

    String imageUrl = await imageRef.getDownloadURL();
    print(imageUrl);

    return imageUrl;
  }

  @override
  void initState() {
    super.initState();
    _getimg();
    addRecipeList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
        child: Column(
          children: [
            // Material(
            //   borderRadius: BorderRadius.circular(8),
            //   elevation: 5,
            //   shadowColor: Colors.grey,
            //   child: TextField(
            //     // cursorColor: Colors.red,
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       contentPadding: EdgeInsets.all(20.0),
            //       hintText: 'Search ...',
            //       suffixIcon: Icon(
            //         Icons.search,
            //         color: Colors.black,
            //       ),
            //       // fillColor: Colors.black,
            //     ),
            //     onChanged: (text) {
            //       // model.text = text; // <= modelのtext変数に値を渡す
            //       // model.search(); // <= model内に定義した関数で検索処理を実行
            //     },
            //   ),
            // ),
            Container(
              child: Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipeList.length,
                  itemBuilder: (context, index) {
                    var ImagePath = recipeList[index].image_path;
                    var StoragePath = recipeList[index].storage_path;
                    Future<String> resultImage =
                        _get_image(ImagePath!, StoragePath!);
                    return GestureDetector(
                      onTap: () {
                        print('tap');
                      },
                      onLongPress: () {
                        print('long press');
                      },
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.grey.withOpacity(.4),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.only(top: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 180,
                                  child: SizedBox(
                                    width: double.infinity,
                                    // fit: BoxFit.contain,
                                    child: Image.asset(
                                        'assets/images/default_image.jpg'),
                                  ),
                                  // height: 180,
                                  // child: FittedBox(
                                  //   fit: BoxFit.contain,
                                  //   child: Image.asset(
                                  //       'assets/images/default_image.jpg'),
                                  // ),
                                )
                                // SvgPicture.asset(resultImage),
                                // Ink.image(
                                //   image: Image.asset(
                                //       'assets/images/default_image.jpg'),
                                //   height: 180,
                                //   fit: BoxFit.cover,
                                // ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16, left: 16, bottom: 24, right: 16),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              recipeList[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.keyboard_control_sharp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
