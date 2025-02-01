class Category {
  final List<String> categories;

  Category({required this.categories});

  factory Category.fromJson(List<dynamic> json) {
    return Category(
      categories: List<String>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories,
    };
  }
}
