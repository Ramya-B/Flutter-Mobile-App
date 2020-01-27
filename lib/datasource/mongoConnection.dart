import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

Db db = new Db("mongodb://localhost:27017/mongo_dart-blog");
await db.open();
