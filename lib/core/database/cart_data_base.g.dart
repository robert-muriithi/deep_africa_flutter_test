// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data_base.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorCartDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CartDatabaseBuilder databaseBuilder(String name) =>
      _$CartDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CartDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$CartDatabaseBuilder(null);
}

class _$CartDatabaseBuilder {
  _$CartDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$CartDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$CartDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<CartDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CartDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CartDatabase extends CartDatabase {
  _$CartDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao? _productsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `products` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `image` TEXT NOT NULL, `price` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get productsDao {
    return _productsDaoInstance ??= _$CartDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cartEntityInsertionAdapter = InsertionAdapter(
            database,
            'products',
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'image': _imagesTypeConverters.encode(item.image),
                  'price': item.price
                }),
        _cartEntityUpdateAdapter = UpdateAdapter(
            database,
            'products',
            ['id'],
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'image': _imagesTypeConverters.encode(item.image),
                  'price': item.price
                }),
        _cartEntityDeletionAdapter = DeletionAdapter(
            database,
            'products',
            ['id'],
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'image': _imagesTypeConverters.encode(item.image),
                  'price': item.price
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartEntity> _cartEntityInsertionAdapter;

  final UpdateAdapter<CartEntity> _cartEntityUpdateAdapter;

  final DeletionAdapter<CartEntity> _cartEntityDeletionAdapter;

  @override
  Future<List<CartEntity>> getCarts() async {
    return _queryAdapter.queryList('SELECT * FROM products',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            description: row['description'] as String,
            image: _imagesTypeConverters.decode(row['image'] as String),
            price: row['price'] as int));
  }

  @override
  Future<CartEntity?> getCartById(String id) async {
    return _queryAdapter.query('SELECT * FROM products WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            description: row['description'] as String,
            image: _imagesTypeConverters.decode(row['image'] as String),
            price: row['price'] as int),
        arguments: [id]);
  }

  @override
  Future<void> clearCart() async {
    await _queryAdapter.queryNoReturn('DELETE FROM products');
  }

  @override
  Future<void> insertToCart(CartEntity product) async {
    await _cartEntityInsertionAdapter.insert(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCarts(List<CartEntity> products) async {
    await _cartEntityInsertionAdapter.insertList(
        products, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCart(CartEntity product) async {
    await _cartEntityUpdateAdapter.update(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeCart(CartEntity product) async {
    await _cartEntityDeletionAdapter.delete(product);
  }
}

// ignore_for_file: unused_element
final _imagesTypeConverters = ImagesTypeConverters();
