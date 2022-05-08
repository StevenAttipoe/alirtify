class NewsItem {
  final String title;
  final String description;
  final String urlToImage;

  NewsItem({
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
    );
  }
}
