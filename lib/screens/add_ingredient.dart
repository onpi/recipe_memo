import 'package:flutter/material.dart';
import 'package:recipe_memo/model/ingredient.dart';
import 'package:recipe_memo/helper/generate_nonce.dart';
import 'package:recipe_memo/utilities/color.dart';

class AddIngredientPage extends StatefulWidget {
  @override
  _AddIngredientPage createState() => _AddIngredientPage();
}

class _AddIngredientPage extends State<AddIngredientPage> {
  Ingredient ingredient = Ingredient(id: '', title: '', quantity: '');

  @override
  void initState() {
    super.initState();
    // id = ingredientData.ingredientCount + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "材料",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
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
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFFF9500), width: 3),
                    ),
                  ),
                  child: Text(
                    '材料',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFD6E4EC),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFD6E4EC),
                        ),
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'トマト',
                    ),
                    onChanged: (text) {
                      // dataList['title'] = text;
                      // ingredientName = text;
                      ingredient.title = text;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Color(0xFFFF9500), width: 3),
                          ),
                        ),
                        child: Text(
                          '分量',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Color(0xFFD6E4EC),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Color(0xFFD6E4EC),
                              ),
                            ),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: '大さじ1杯',
                          ),
                          onChanged: (text) {
                            ingredient.quantity = text;
                            // dataList['detail'] = text;
                            // ingredientQuantity = text;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: SizedBox(
                          height: 44,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              primary: Color(lightThemeColor),
                            ),
                            onPressed: () {
                              // 両方に入力されていないと追加できない
                              if (ingredient.title != '' &&
                                  ingredient.quantity != '') {
                                setState(() {
                                  var data = {
                                    'id': generateNonce(),
                                    'title': ingredient.title,
                                    'quantity': ingredient.quantity
                                  };
                                  Navigator.pop(context, data);
                                });
                              }
                            },
                            child: const Text(
                              '追加',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
