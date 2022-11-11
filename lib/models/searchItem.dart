// ignore: file_names
class SearchItem {
  final String title;
  final String fullName;

  SearchItem({required this.title, required this.fullName});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      title: json["data"]["title"] as String,
      fullName: json["data"]["author_fullname"] as String,
    );
  }
}
