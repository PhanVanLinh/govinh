import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemUI {
  final bool isLoading;
  final String? error;

  RedeemUI({required this.isLoading, this.error});
}

class RedeemCubit extends Cubit<RedeemUI> {
  RedeemCubit() : super(RedeemUI(isLoading: false));

  void redeem(String phoneNumber, String code) async {
    if(code.isEmpty) {
      emit(RedeemUI(isLoading: true, error: "Sai mã"));
      return;
    }
    if(phoneNumber.isEmpty) {
      emit(RedeemUI(isLoading: false, error: "Thiếu số điện thoại"));
      return;
    }
    emit(RedeemUI(isLoading: true, error: null));
  }
}