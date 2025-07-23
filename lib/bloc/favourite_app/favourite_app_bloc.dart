import 'package:bloc_practice/bloc/favourite_app/favourite_app_event.dart';
import 'package:bloc_practice/bloc/favourite_app/favourite_app_state.dart';
import 'package:bloc_practice/model/favourite_item_model.dart';
import 'package:bloc_practice/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppBloc extends Bloc<FavouriteAppEvent, FavouriteAppState> {
  List<FavouriteItemModel> favouriteItems = [];
  List<FavouriteItemModel> tempfavouriteItems = [];
  FavouriteRepository favouriteRepository;

  FavouriteAppBloc(this.favouriteRepository)
    : super(const FavouriteAppState()) {
    on<FetchFavouriteList>(fetchFavouriteList);
    on<FavouriteItem>(favouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unselectItem);
    on<DeleteItems>(_deleteItems);
  }

  void fetchFavouriteList(
    FetchFavouriteList event,
    Emitter<FavouriteAppState> emit,
  ) async {
    favouriteItems = await favouriteRepository.fetchItem();
    emit(
      state.copyWith(
        favouritelist: List.from(favouriteItems),
        listStatus: ListStatus.success,
      ),
    );
  }

  void favouriteItem(
    FavouriteItem event,
    Emitter<FavouriteAppState> emit,
  ) async {
    final index = favouriteItems.indexWhere((e) => e.id == event.item.id);
    if (tempfavouriteItems.contains(favouriteItems[index])) {
      tempfavouriteItems.remove(favouriteItems[index]);
      tempfavouriteItems.add(event.item);
    }
    favouriteItems[index] = event.item;
    emit(
      state.copyWith(
        favouritelist: List.from(favouriteItems),
        tempfavouritelist: List.from(tempfavouriteItems),
      ),
    );
  }

  void _selectItem(SelectItem event, Emitter<FavouriteAppState> emit) async {
    tempfavouriteItems.add(event.item);
    emit(state.copyWith(tempfavouritelist: List.from(tempfavouriteItems)));
  }

  void _unselectItem(
    UnSelectItem event,
    Emitter<FavouriteAppState> emit,
  ) async {
    tempfavouriteItems.remove(event.item);
    emit(state.copyWith(tempfavouritelist: List.from(tempfavouriteItems)));
  }

  void _deleteItems(DeleteItems event, Emitter<FavouriteAppState> emit) async {
    for (final item in tempfavouriteItems) {
      favouriteItems.remove(item);
    }
    tempfavouriteItems.clear();
    emit(
      state.copyWith(
        favouritelist: List.from(favouriteItems),
        tempfavouritelist: List.from(tempfavouriteItems),
      ),
    );
  }
}
