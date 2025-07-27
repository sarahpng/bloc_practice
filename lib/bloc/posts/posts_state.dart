import 'package:bloc_practice/model/post_model.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:equatable/equatable.dart';

class PostsState extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postList;
  final List<PostModel> tempPostList;
  final String message;
  final String searchMessage;

  const PostsState({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostModel>[],
    this.tempPostList = const <PostModel>[],
    this.message = '',
    this.searchMessage = '',
  });

  PostsState copyWith({
    PostStatus? postStatus,
    List<PostModel>? postList,
    List<PostModel>? tempPostList,
    String? message,
    String? searchMessage,
  }) {
    return PostsState(
      postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      message: message ?? this.message,
      searchMessage: searchMessage ?? this.searchMessage,
      tempPostList: tempPostList ?? this.tempPostList,
    );
  }

  @override
  List<Object?> get props => [
    postStatus,
    postList,
    message,
    tempPostList,
    searchMessage,
  ];
}
