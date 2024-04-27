import 'package:hive/hive.dart';

part 'wishlist.g.dart';

@HiveType(typeId: 3)
class WishListType {
  @HiveField(0)
  String id;

  @HiveField(1)
  String category;

  @HiveField(2)
  String? name;

  WishListType({required this.id, required this.category, this.name});

  factory WishListType.fromJson(Map<String, dynamic> json) {
    return WishListType(
      id: json['id'],
      category: json['category'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'category': category, 'name': name};
  }
}
