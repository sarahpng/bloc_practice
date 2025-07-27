import 'package:bloc_practice/bloc/posts/posts_event.dart';
import 'package:bloc_practice/bloc/posts/posts_state.dart';
import 'package:bloc_practice/model/post_model.dart';
import 'package:bloc_practice/repository/posts_repository.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostRepository postRepository;
  List<PostModel> tempList = [];
  PostsBloc(this.postRepository) : super(PostsState()) {
    on<PostFetched>(_postFetched);
    on<SearchItem>(_searchItem);
  }

  _postFetched(PostFetched event, Emitter<PostsState> emit) async {
    await postRepository
        .fetchPosts()
        .then((value) {
          emit(
            state.copyWith(
              postStatus: PostStatus.success,
              message: 'success',
              postList: value,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              postStatus: PostStatus.failure,
              message: error.toString(),
            ),
          );
        });
  }

  _searchItem(SearchItem event, Emitter<PostsState> emit) {
    if (event.stringSearch.isEmpty) {
      emit(state.copyWith(tempPostList: [], searchMessage: ''));
    } else {
      tempList =
          state.postList
              .where(
                (value) => value.email.toString().toLowerCase().contains(
                  event.stringSearch.toLowerCase(),
                ),
              )
              .toList();
      if (tempList.isEmpty) {
        emit(
          state.copyWith(
            tempPostList: tempList,
            searchMessage: 'No data found',
          ),
        );
      } else {
        emit(state.copyWith(tempPostList: tempList, searchMessage: ''));
      }
    }
  }
}
