import '../../data/models/post_model.dart';
import '../../domain/entities/post.dart';

enum SortOrder { newest, oldest }

class FeedState {
  final List<Post> posts;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? cursor;
  final String? error;
  final SortOrder sortOrder;

  const FeedState({
    required this.isLoading,
    required this.posts,
    required this.error,
    required this.cursor,
    required this.hasReachedEnd,
    required this.isLoadingMore,
    required this.sortOrder,
  });

  factory FeedState.initial() {
    return const FeedState(
      isLoading: true,
      posts: [],
      error: null,
      cursor: null,
      hasReachedEnd: false,
      isLoadingMore: false,
      sortOrder: SortOrder.newest,
    );
  }

  FeedState copyWith({
    bool? isLoading,
    List<Post>? posts,
    String? error,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    final String? cursor,
    SortOrder? sortOrder,
  }) {
    return FeedState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      error: error,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      cursor: cursor ?? this.cursor,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
