import 'dart:convert';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:nova_store/nova_store/Models/product_model.dart';

class ProductSqliteDb {
  static late Database _database;

  static const String dbPath = 'products.db';
  static const String tableName = 'products';

  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnDescription = 'description';
  static const String columnCategory = 'category';
  static const String columnPrice = 'price';
  static const String columnDiscount = 'discount';
  static const String columnRating = 'rating';
  static const String columnStock = 'stock';
  static const String columnStatus = 'status';
  static const String columnImages = 'images';
  static const String columnReviews = 'reviews';
  static const String columnThumbnail = 'thumbnail';
  static const String columnWarranty = 'warranty';

  static Future<void> init() async {
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        log('Creating table...');
        await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT,
            $columnDescription TEXT,
            $columnCategory TEXT,
            $columnPrice REAL,
            $columnDiscount REAL,
            $columnRating REAL,
            $columnStock INTEGER,
            $columnStatus TEXT,
            $columnImages TEXT,
            $columnReviews TEXT,
            $columnThumbnail TEXT,
            $columnWarranty TEXT
          )
        ''');
      },
      onOpen: (db) {
        log('✅ Database opened successfully');
      },
    );
  }

  //  INSERT
  static Future<int> insertProduct(ProductModel product) async {
    final id = await _database.insert(tableName, {
      columnId: product.id,
      columnTitle: product.title,
      columnDescription: product.description,
      columnCategory: product.category,
      columnPrice: product.price,
      columnDiscount: product.discountPercentage,
      columnRating: product.rating,
      columnStock: product.stock,
      columnStatus: product.availabilityStatus,
      columnImages: jsonEncode(product.images),
      columnReviews: jsonEncode(product.reviews.map((r) => r.toMap()).toList()),
      columnThumbnail: product.thumbnail,
      columnWarranty: product.warrantyInformation,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    log('Product inserted with id $id');
    return id;
  }

  // READ
  static Future<List<ProductModel>> getProducts() async {
    final result = await _database.query(tableName);
    return result.map((map) {
      return ProductModel(
        id: map[columnId] as int,
        title: map[columnTitle] as String,
        description: map[columnDescription] as String,
        category: map[columnCategory] as String,
        price: (map[columnPrice] as num).toDouble(),
        discountPercentage: (map[columnDiscount] as num).toDouble(),
        rating: (map[columnRating] as num).toDouble(),
        stock: map[columnStock] as int,
        availabilityStatus: map[columnStatus] as String,
        images: List<String>.from(
          jsonDecode(map[columnImages] as String? ?? '[]'),
        ),
        reviews: (jsonDecode(map[columnReviews] as String? ?? '[]') as List)
            .map((r) => RatingModel.fromJson(Map<String, dynamic>.from(r)))
            .toList(),
        thumbnail: map[columnThumbnail] as String,
        warrantyInformation: map[columnWarranty] as String,
      );
    }).toList();
  }

  //  UPDATE
  static Future<void> updateProduct(ProductModel product) async {
    await _database.update(
      tableName,
      {
        columnTitle: product.title,
        columnDescription: product.description,
        columnCategory: product.category,
        columnPrice: product.price,
        columnDiscount: product.discountPercentage,
        columnRating: product.rating,
        columnStock: product.stock,
        columnStatus: product.availabilityStatus,
        columnImages: jsonEncode(product.images),
        columnReviews: jsonEncode(
          product.reviews.map((r) => r.toMap()).toList(),
        ),
        columnThumbnail: product.thumbnail,
        columnWarranty: product.warrantyInformation,
      },
      where: '$columnId = ?',
      whereArgs: [product.id],
    );
    log('Product ${product.id} updated');
  }

  //  DELETE
  static Future<void> deleteProduct(int id) async {
    final result = await _database.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    log('Deleted $result row(s)');
  }
}
