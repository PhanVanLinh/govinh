import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govinh/data/model/shop.dart';
import 'package:govinh/feature/home/home_usecase.dart';

class HomeAction {}

class GoSuccessAction extends HomeAction {
}

class HomeUI {
  final bool isLoading;
  final List<Shop> shops;
  final String? error;
  final HomeAction? action;

  HomeUI({required this.shops, required this.isLoading, this.error, this.action});

  HomeUI copyWith({HomeAction? action}) {
    return HomeUI(
      shops: shops,
      isLoading: isLoading,
      error: error,
      action: action,
    );
  }
}

class HomeCubit extends Cubit<HomeUI> {
  HomeUseCase homeUseCase = HomeUseCase();

  HomeCubit() : super(HomeUI(isLoading: true, shops: []));

  void home() async {
    (await homeUseCase.execute(HomeInput())).fold((error) {
      emit(HomeUI(shops: [], isLoading: false, error: error.toString()));
    }, (response) {
      emit(HomeUI(shops: response, isLoading: false));
    });
  }
}
