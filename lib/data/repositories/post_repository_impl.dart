import 'package:synoption_data_feed/data/datasource/post_remote_datasource.dart';
import 'package:synoption_data_feed/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remote;

  PostRepositoryImpl(this.remote);

  @override
  Future<Page> fetchPosts({String? cursor}) {
    return remote.fetchPosts(cursor: cursor);
  }
}
