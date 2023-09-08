// class Product {
//   final int id;
//   final int categoryId;
//   final String name;
//   final String description;
//   final double price;
//   final String image;
//   final int stock;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Product({
//     required this.id,
//     required this.categoryId,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.image,
//     required this.stock,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       categoryId: json['category_id'],
//       name: json['name'],
//       description: json['description'],
//       price: json['price'].toDouble(),
//       image: json['image'],
//       stock: json['stock'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }
