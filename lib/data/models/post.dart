import 'package:belove_app/data/models/user.dart';

class Post {
  String? id;
  String? posterId;
  User? poster;
  List<String>? images;
  String? title;
  DateTime? createdAt;

  Post({
    this.id,
    this.posterId,
    this.images,
    this.title,
    this.createdAt,
    this.poster,
  });
}
