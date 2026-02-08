import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent * 0.8) {
        context.read<FeedBloc>().add(FeedFetched());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Synoption Data Feed'),
        actions: [
          IconButton(
            onPressed: () => context.read<FeedBloc>().add(FeedSortToggled()),
            icon: Icon(Icons.sort,color: Colors.red.withOpacity(0.7),size: 40,),
          ),
        ],
      ),

      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state.isLoading && state.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.posts.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<FeedBloc>().add(FeedRetry()),
                child: Text("Retry"),
              ),
            );
          }
          if (state.posts.isEmpty) return Center(child: Text("No posts found"));
          return RefreshIndicator(
            onRefresh: () async {
              context.read<FeedBloc>().add(FeedRefreshed());
            },
            child: ListView.builder(
              controller: controller,
              itemCount: state.hasReachedEnd
                  ? state.posts.length
                  : state.posts.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  return const BottomLoader();
                }

                final post = state.posts[index];
                return PostCard(post: post);
              },
            ),
          );
        },
      ),
    );
  }
}
