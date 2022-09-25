class Review {
  final String name;
  final String review;
  final String date;

  Review({
    required this.name,
    required this.review,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> review) => Review(
    name: review['name'],
    review: review['review'],
    date: review['date'],
  );
}

List<Review> parseCategories(List<dynamic>? reviews) {
  if (reviews == null) {
    return [];
  }

  return reviews.map((review) => Review.fromJson(review)).toList();
}