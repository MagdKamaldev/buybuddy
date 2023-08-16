import 'package:buybuddy/cubit/favourites/favourites_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../models/favourites_model.dart';
import '../../shared/networks/dio_helper.dart';
import '../../shared/networks/end_points.dart';



Map<int, bool> favourites = {};

class FavoritesCubit extends Cubit<FavoritesStates> with StateStreamable<FavoritesStates>{

   FavoritesCubit() : super(FavoritesInitialState()) {
    getFavouritesData();
  }

  static FavoritesCubit get(context) => BlocProvider.of(context);

  FavoritesModel? favoritesModel;

  ChangeFavouritesmodel? changeFavouritesmodel;

  
 

  void changeFavourites(int productId, context) {
    favourites[productId] = !favourites[productId]!;
    emit(ChangeFavoritesLoadingState());
    DioHelper.postData(
      url: favorites,
      data: {"product_id": productId},
      authorization: token,
    ).then((value) {
      changeFavouritesmodel = ChangeFavouritesmodel.fromJson(value.data);
      if (!changeFavouritesmodel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavouritesData();
      }

      emit(ChangeFavoritesSuccessState());
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ChangeFavoritesErrorState());
    });
  }


  void getFavouritesData() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: favorites, authorization: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      emit(GetFavoritesErrorState());
    });
  }
}
