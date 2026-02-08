import 'package:synoption_data_feed/data/models/post_model.dart';

class Page {
  final List<PostModel> items;
  final String? nextCursor;

  Page(this.items, this.nextCursor);
}

class PostRemoteDataSource {
  Future<Page> fetchPosts({String? cursor, int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (DateTime.now().millisecondsSinceEpoch % 7 == 0) {
      throw Exception("Random network error");
    }

    final start = cursor == null ? 0 : int.parse(cursor);
    final items = List.generate(limit, (i) {
      final id = start + i;
      return PostModel(
        id: id.toString(),
        title: "Post #$id",
        body: "This is a preview for post $id",
        createdAt: DateTime.now().subtract(Duration(minutes: id)),
      );
    });

    if (start > 0 && items.isNotEmpty) {
      items[0] = PostModel(
        id: (start - 1).toString(),
        title: items[0].title,
        body: items[0].body,
        createdAt: items[0].createdAt,
      );
    }

    final next = start + limit;
    return Page(items, next >= 60 ? null : next.toString());
  }
}
