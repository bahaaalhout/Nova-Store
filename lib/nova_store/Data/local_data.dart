class ClothesModel {
  final List<String> category;
  final String title;
  final String image;

  ClothesModel({
    required this.category,
    required this.title,
    required this.image,
  });

  static List<ClothesModel> categories = [
    ClothesModel(
      category: ['mens-shirts'],
      image: 'assets/shirt.png',
      title: 'Shirt',
    ),
    ClothesModel(
      category: ['womens-dresses'],
      image: 'assets/woman-clothes.png',
      title: 'Dresses',
    ),
    ClothesModel(
      category: ['mens-shoes', 'womens-shoes'],
      image: 'assets/shoe.png',
      title: 'Shoes',
    ),
    ClothesModel(
      category: ['mens-watches', 'womens-watches'],
      image: 'assets/watch.png',
      title: 'Watches',
    ),
    ClothesModel(
      category: ['womens-bags'],
      image: 'assets/bag.png',
      title: 'bags',
    ),
    ClothesModel(
      category: ['womens-jewellery'],
      image: 'assets/diamond.png',
      title: 'jewellery',
    ),
  ];

  static const List<String> imgList = [
    'assets/slider1.jpeg',
    'assets/slider2.jpeg',
    'assets/slider3.jpeg',
    'assets/slider4.jpeg',
  ];
}
