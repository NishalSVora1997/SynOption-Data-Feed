
class Post {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;

  Post({required this.id, required this.title, required this.body, required this.createdAt});

  Post copyWith({String? id}) => Post(
    id: id ?? this.id,
    title: title,
    body: body,
    createdAt: createdAt,
  );
}

class Page {
  final List<Post> items;
  final String? nextCursor;
  Page(this.items, this.nextCursor);
}