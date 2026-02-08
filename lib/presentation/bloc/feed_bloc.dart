import 'package:synoption_data_feed/domain/usecases/fetch_posts_usecase.dart';

import 'feed_event.dart';
import 'feed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FetchPostsUseCase fetchPosts;

  FeedBloc(this.fetchPosts) : super(FeedState.initial()) {
    on<FeedFetched>(_onFetch);
    on<FeedRefreshed>(_onRefresh);
    on<FeedRetry>(_onRetry);
    on<FeedSortToggled>(_onSortToggle);
  }

  Future<void> _onFetch(FeedFetched event, Emitter<FeedState> emit) async {
    if (state.isLoadingMore || state.hasReachedEnd) return;

    emit(
      state.copyWith(
        isLoading: state.posts.isEmpty,
        isLoadingMore: state.posts.isNotEmpty,
        error: null,
      ),
    );

    try {
      final page = await fetchPosts(cursor: state.cursor);
      final existingIds = state.posts.map((e) => e.id).toSet();
      final newPosts = page.items.where((p) => !existingIds.contains(p.id));
      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          hasReachedEnd: page.nextCursor == null,
          posts: [...state.posts, ...newPosts],
          cursor: page.nextCursor,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRefresh(FeedRefreshed event, Emitter<FeedState> emit) async {
    emit(FeedState.initial());
    add(FeedFetched());
  }

  Future<void> _onRetry(FeedRetry event, Emitter<FeedState> emit) async {
    add(FeedFetched());
  }

  Future<void> _onSortToggle(
    FeedSortToggled event,
    Emitter<FeedState> emit,
  ) async {
    final newOrder = state.sortOrder == SortOrder.newest
        ? SortOrder.oldest
        : SortOrder.newest;

    final sorted = [...state.posts]
      ..sort(
        (a, b) => newOrder == SortOrder.newest
            ? b.createdAt.compareTo(a.createdAt)
            : a.createdAt.compareTo(b.createdAt),
      );
    emit(state.copyWith(posts: sorted, sortOrder: newOrder));
  }
}
