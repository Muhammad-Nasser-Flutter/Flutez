import '../../Track/Model/track_model.dart';

abstract class SearchStates{}
class SearchInitialState extends SearchStates{}

class SearchLoadingState extends SearchStates{}
class SearchSuccessState extends SearchStates{
  List<Track> searches ;
  SearchSuccessState(this.searches);
}
class SearchErrorState extends SearchStates{}