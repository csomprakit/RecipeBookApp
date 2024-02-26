import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/ReadPage.dart';
import 'package:recipe_book_app/database/recipe_database.dart';
import 'package:recipe_book_app/database/recipe_dao.dart';
import 'package:recipe_book_app/database/recipe_entity.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

//part 'package:recipe_book_app/database/recipe_database.g.dart';


abstract class Database {
  Future<int> fetchData();
}

class MockRecipeDao implements RecipeDao {
  @override
  Future<void> addRecipe(RecipeEntity event) async {}

  @override
  Stream<RecipeEntity?> findRecipeById(int id) {
    // TODO: implement findRecipeById
    throw UnimplementedError();
  }

  @override
  Future<List<RecipeEntity>> listAllEvents() {
    // TODO: implement listAllEvents
    throw UnimplementedError();
  }

  @override
  Future<List<String>> listCategories() {
    // TODO: implement listCategories
    throw UnimplementedError();
  }
  
}

class MockRecipeDatabase implements RecipeDatabase {
  @override
  RecipeDao get recipeDao => MockRecipeDao();
  @override
  Future<int> fetchData() async {
    return Future.delayed(Duration(seconds: 1), () => 42);
  }

  @override
  late StreamController<String> changeListener;

  @override
  late sqflite.DatabaseExecutor database;

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }
}

main() {
  testWidgets('', (tester) async {
    var mockDatabase = MockRecipeDatabase();
    await tester.pumpWidget(
      MaterialApp(home: ReadPage(database: mockDatabase,))
    );
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();
    expect(find.text('Description:'), findsOneWidget);
  });


}