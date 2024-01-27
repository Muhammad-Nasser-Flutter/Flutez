
import 'package:flutez/core/cache_helper/cache_helper.dart';
import 'package:flutez/core/cache_helper/cache_values.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/LogoutCubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutStates>{
  LogoutCubit():super(LogoutInitialState());
  static LogoutCubit get(context) =>BlocProvider.of(context);

  void logout({required context}){
    CacheHelper.removeData(key: CacheKeys.uId);
    emit(LogoutSuccessState());
  }
}