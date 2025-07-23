import 'package:bloc_practice/bloc/favourite_app/favourite_app_bloc.dart';
import 'package:bloc_practice/bloc/favourite_app/favourite_app_event.dart';
import 'package:bloc_practice/bloc/favourite_app/favourite_app_state.dart';
import 'package:bloc_practice/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppScreen extends StatefulWidget {
  const FavouriteAppScreen({super.key});

  @override
  State<FavouriteAppScreen> createState() => _FavouriteAppScreenState();
}

class _FavouriteAppScreenState extends State<FavouriteAppScreen> {
  @override
  void initState() {
    context.read<FavouriteAppBloc>().add(FetchFavouriteList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        actions: [
          BlocBuilder<FavouriteAppBloc, FavouriteAppState>(
            builder: (context, state) {
              return state.tempfavouritelist.isNotEmpty
                  ? IconButton(
                    onPressed: () {
                      context.read<FavouriteAppBloc>().add(DeleteItems());
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  )
                  : SizedBox();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FavouriteAppBloc, FavouriteAppState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return Center(child: const CircularProgressIndicator());
              case ListStatus.failed:
                return const Center(child: Text('Something Went Wrong'));
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.favouritelist.length,
                  itemBuilder: (context, index) {
                    final item = state.favouritelist[index];
                    return Card(
                      child: ListTile(
                        title: Text(item.value),
                        leading: Checkbox(
                          value:
                              state.tempfavouritelist.contains(item)
                                  ? true
                                  : false,
                          onChanged: (value) {
                            if (value!) {
                              print('true');
                              context.read<FavouriteAppBloc>().add(
                                SelectItem(item: item),
                              );
                            } else {
                              print('false');
                              context.read<FavouriteAppBloc>().add(
                                UnSelectItem(item: item),
                              );
                            }
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            FavouriteItemModel itemModel = FavouriteItemModel(
                              id: item.id,
                              value: item.value,
                              isFavourite: item.isFavourite ? false : true,
                            );
                            context.read<FavouriteAppBloc>().add(
                              FavouriteItem(item: itemModel),
                            );
                          },
                          icon: Icon(
                            item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: item.isFavourite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
