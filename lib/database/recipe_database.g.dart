// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorRecipeDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$RecipeDatabaseBuilder databaseBuilder(String name) =>
      _$RecipeDatabaseBuilder(name);

  /// Creates a database builder for an in-memory database.
  /// Information stored in an in-memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$RecipeDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$RecipeDatabaseBuilder(null);
}

class _$RecipeDatabaseBuilder {
  _$RecipeDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$RecipeDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$RecipeDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<RecipeDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$RecipeDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$RecipeDatabase extends RecipeDatabase {
  _$RecipeDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RecipeDao? _recipeDaoInstance;

  Future<sqflite.Database> open(
      String path,
      List<Migration> migrations, [
        Callback? callback,
      ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Recipe` (`id` INTEGER NOT NULL, `recipeName` TEXT NOT NULL, `description` TEXT NOT NULL, `ingredients` TEXT NOT NULL, `category` TEXT NOT NULL, `imagePath` TEXT NOT NULL, `rating` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RecipeDao get recipeDao {
    return _recipeDaoInstance ??= _$RecipeDao(database, changeListener);
  }
}

class _$RecipeDao extends RecipeDao {
  _$RecipeDao(
      this.database,
      this.changeListener,
      )   : _queryAdapter = QueryAdapter(database, changeListener),
        _recipeEntityInsertionAdapter = InsertionAdapter(
            database,
            'Recipe',
                (RecipeEntity item) => <String, Object?>{
              'id': item.id,
              'recipeName': item.recipeName,
              'description': item.description,
              'ingredients': item.ingredients,
              'category': item.category,
              'imagePath': item.imagePath,
              'rating':item.rating
            },
            changeListener),
        _recipeEntityDeletionAdapter = DeletionAdapter(
            database,
            'Recipe',
            // Columns to check for deletion
            ['id'],
            // Mapper for deletion
                (RecipeEntity item) => <String, Object?>{'id': item.id},
            changeListener),
        _recipeEntityUpdateAdapter = UpdateAdapter(
            database,
            'Recipe',
            // Columns to check for update
            ['id'],
            // Mapper for update
                (RecipeEntity item) => <String, Object?>{
              'id': item.id,
              'recipeName': item.recipeName,
              'description': item.description,
              'ingredients': item.ingredients,
              'category': item.category,
              'imagePath': item.imagePath,
              'rating':item.rating
            },
            changeListener);

  final sqflite.DatabaseExecutor database;
  final StreamController<String> changeListener;
  final QueryAdapter _queryAdapter;
  final InsertionAdapter<RecipeEntity> _recipeEntityInsertionAdapter;
  final DeletionAdapter<RecipeEntity> _recipeEntityDeletionAdapter;
  final UpdateAdapter<RecipeEntity> _recipeEntityUpdateAdapter;

  @override
  Future<List<RecipeEntity>> listAllEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Recipe',
        mapper: (Map<String, Object?> row) => RecipeEntity(
            row['id'] as int,
            row['recipeName'] as String,
            row['description'] as String,
            row['ingredients'] as String,
            row['category'] as String,
            row['imagePath'] as String,
            row['rating'] as int));
  }

  @override
  Future<List<String>> listCategories() async {
    return _queryAdapter.queryList('SELECT DISTINCT category FROM Recipe',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Stream<RecipeEntity?> findRecipeById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Recipe WHERE id = ?1',
        mapper: (Map<String, Object?> row) => RecipeEntity(
            row['id'] as int,
            row['recipeName'] as String,
            row['description'] as String,
            row['ingredients'] as String,
            row['category'] as String,
            row['imagePath'] as String,
            row['rating'] as int),
        arguments: [id],
        queryableName: 'Recipe',
        isView: false);
  }

  @override
  Future<void> addRecipe(RecipeEntity event) async {
    await _recipeEntityInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRecipe(RecipeEntity event) async {
    await _recipeEntityUpdateAdapter.update(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRecipe(RecipeEntity event) async {
    await _recipeEntityDeletionAdapter.delete(event);
  }

  @override
  Future<int?> getRecipeRating(int id) async {
    final result = await _queryAdapter.query(
      'SELECT rating FROM RecipeEntity WHERE id = ?',
      arguments: [id],
      mapper: (Map<String, Object?> row) {
        final rating = row['rating'] as int?;
        return rating;
      },
    );

    return result;
  }



  @override
  Future<List<RecipeEntity>> listAllRecipes() async {
    return _queryAdapter.queryList('SELECT * FROM Recipe',
        mapper: (Map<String, Object?> row) => RecipeEntity(
            row['id'] as int,
            row['recipeName'] as String,
            row['description'] as String,
            row['ingredients'] as String,
            row['category'] as String,
            row['imagePath'] as String,
            row['rating'] as int));
  }

  @override
  Future<void> updateRecipeRating(int id, int newRating) async {
    await _queryAdapter.queryNoReturn('UPDATE Recipe SET rating = ? WHERE id = ?',
        arguments: [newRating, id]);
  }
}