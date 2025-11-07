class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String availabilityStatus;
  final List<RatingModel> reviews;
  final List images;
  final String thumbnail;
  final String warrantyInformation;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.availabilityStatus,
    required this.reviews,
    required this.images,
    required this.thumbnail,
    required this.warrantyInformation,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      category = json['category'],
      price = json['price'],
      discountPercentage = json['discountPercentage'],
      rating = json['rating'],
      stock = json['stock'],
      availabilityStatus = json['availabilityStatus'],
      reviews = (json['reviews'] as List)
          .map((e) => RatingModel.fromJson(e))
          .toList(),
      images = json['images'],
      thumbnail = json['thumbnail'],
      warrantyInformation = json['warrantyInformation'];
}

class RatingModel {
  double? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  RatingModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  RatingModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] * 1.0;
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['comment'] = comment;
    data['date'] = date;
    data['reviewerName'] = reviewerName;
    data['reviewerEmail'] = reviewerEmail;

    return data;
  }
}
