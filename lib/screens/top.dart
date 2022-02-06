import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recipe_memo/components/emptyAppBar.dart';
import 'package:recipe_memo/model/recipe_data.dart';
import 'package:recipe_memo/service/auth.dart';
import 'package:recipe_memo/model/recipe.dart';
import 'package:recipe_memo/utilities/color.dart';
import 'add_recipe.dart';
import 'package:recipe_memo/helper/user_data.dart';

import 'home.dart';

class TopPage extends StatefulWidget {
  TopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TopPage createState() => _TopPage();
}

class _TopPage extends State<TopPage> {
  List<Recipe> recipeList = [];

  RecipeListModel recipeListModel = RecipeListModel();
  final AuthService _auth = AuthService();

  void addRecipeList() async {
    var recipeItems = await recipeListModel.getResipe();
    recipeList = recipeItems;
    setState(() {});
  }

  int recipeListLength() {
    return recipeList.length;
  }

  // ignore: prefer_final_fields
  List<Widget> _pages = [
    const homePage(),
    const addRecipePage(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    var user = _auth.signInAnon();
    addRecipeList();
  }

  Future<bool> _willPopCallback() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: WillPopScope(
        child: _pages[_selectedIndex],
        onWillPop: _willPopCallback,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: const Color(lightThemeColor),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            activeIcon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
