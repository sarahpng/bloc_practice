import 'package:bloc_practice/bloc/favourite_app/favourite_app_event.dart';
import 'package:bloc_practice/bloc/posts/posts_bloc.dart';
import 'package:bloc_practice/bloc/posts/posts_event.dart';
import 'package:bloc_practice/bloc/posts/posts_state.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    context.read<PostsBloc>().add(PostFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetch data with bloc')),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return Center(child: const CircularProgressIndicator());
            case PostStatus.success:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search with email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (filterKey) {
                        context.read<PostsBloc>().add(SearchItem(filterKey));
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${state.tempPostList.isEmpty ? state.postList.length : state.tempPostList.length} items',
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child:
                          state.searchMessage.isNotEmpty
                              ? Center(child: Text(state.searchMessage))
                              : ListView.builder(
                                itemCount:
                                    state.tempPostList.isEmpty
                                        ? state.postList.length
                                        : state.tempPostList.length,
                                itemBuilder: (context, index) {
                                  final post =
                                      state.tempPostList.isEmpty
                                          ? state.postList[index]
                                          : state.tempPostList[index];
                                  return Card(
                                    child: ListTile(
                                      title: Text(post.email!),
                                      subtitle: Text(post.body!),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              );
            case PostStatus.failure:
              return Center(child: Text(state.message));
          }
        },
      ),
    );
  }
}
