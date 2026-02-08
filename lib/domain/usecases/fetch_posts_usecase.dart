import '../../data/datasource/post_remote_datasource.dart';
import '../../data/models/post_model.dart';
import '../repositories/post_repository.dart';

class FetchPostsUseCase {
  final PostsRepository repository;

  FetchPostsUseCase(this.repository);

  Future<Page> call({String? cursor}) async {
    return await repository.fetchPosts(cursor: cursor);
  }
}
