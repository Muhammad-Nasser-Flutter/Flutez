abstract class FavoritesStates{}

class FavoritesInitial extends FavoritesStates{}

class GetFavoritesSuccessState extends FavoritesStates{}
class GetFavoritesErrorState extends FavoritesStates{}

class AddFavoriteSuccessState extends FavoritesStates{}
class AddFavoriteErrorState extends FavoritesStates{}

class RemoveFavoriteSuccessState extends FavoritesStates{}
class RemoveFavoriteErrorState extends FavoritesStates{}
