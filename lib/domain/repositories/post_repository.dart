import '../../data/datasource/post_remote_datasource.dart';
import '../../data/models/post_model.dart';

abstract class PostsRepository {
  Future<Page> fetchPosts({String? cursor});
}