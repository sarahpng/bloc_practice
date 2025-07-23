import 'package:bloc_practice/model/favourite_item_model.dart';
import 'package:equatable/equatable.dart';

enum ListStatus { loading, success, failed }

class FavouriteAppState extends Equatable {
  final List<FavouriteItemModel> favouritelist;
  final List<FavouriteItemModel> tempfavouritelist;
  final ListStatus listStatus;
  const FavouriteAppState({
    this.favouritelist = const [],
    this.tempfavouritelist = const [],
    this.listStatus = ListStatus.loading,
  });

  FavouriteAppState copyWith({
    List<FavouriteItemModel>? favouritelist,
    List<FavouriteItemModel>? tempfavouritelist,
    ListStatus? listStatus,
  }) {
    return FavouriteAppState(
      favouritelist: favouritelist ?? this.favouritelist,
      tempfavouritelist: tempfavouritelist ?? this.tempfavouritelist,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  @override
  List<Object?> get props => [favouritelist, tempfavouritelist, listStatus];
}
