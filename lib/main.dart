import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synoption_data_feed/data/datasource/post_remote_datasource.dart';
import 'package:synoption_data_feed/data/repositories/post_repository_impl.dart';
import 'package:synoption_data_feed/domain/usecases/fetch_posts_usecase.dart';
import 'package:synoption_data_feed/presentation/bloc/feed_bloc.dart';
import 'package:synoption_data_feed/presentation/bloc/feed_event.dart';
import 'package:synoption_data_feed/presentation/pages/feed_page.dart';

void main() {
  final remote = PostRemoteDataSource();
  final repo = PostRepositoryImpl(remote);
  final useCase = FetchPostsUseCase(repo);
  runApp(MyApp(useCase));
}

class MyApp extends StatelessWidget {
  final FetchPostsUseCase useCase;

  const MyApp(this.useCase, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => FeedBloc(useCase)..add(FeedFetched()),
        child: FeedPage(),
      ),
    );
  }
}
