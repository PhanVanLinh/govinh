import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govinh/data/source/remote/service/base_client.dart';
import 'package:govinh/feature/redeem/usecase/redeem_usecase.dart';

class RedeemAction {}
class NeedAuthAction extends RedeemAction {
  final String phoneNumber;

  NeedAuthAction({required this.phoneNumber});
}
class GoSuccessAction extends RedeemAction {
  final String phoneNumber;

  GoSuccessAction({required this.phoneNumber});
}

class RedeemUI {
  final bool isLoading;
  final String? error;
  final RedeemAction? action;

  RedeemUI({required this.isLoading, this.error, this.action});

  RedeemUI copyWith({RedeemAction? action}) {
    return RedeemUI(
      isLoading: isLoading,
      error: error,
      action: action,
    );
  }
}

class RedeemCubit extends Cubit<RedeemUI> {
  RedeemUseCase redeemUseCase = RedeemUseCase();

  RedeemCubit() : super(RedeemUI(isLoading: false));

  void redeem(String shopSlug, String phoneNumber, String code) async {
    if (code.isEmpty) {
      emit(RedeemUI(isLoading: true, error: "Sai mã"));
      return;
    }
    if (phoneNumber.isEmpty) {
      emit(RedeemUI(isLoading: false, error: "Thiếu số điện thoại"));
      return;
    }
    emit(RedeemUI(isLoading: true, error: null));
      (await redeemUseCase.execute(RedeemInput(phoneNumber: phoneNumber, code: code, shopSlug: shopSlug))).fold
      ((error) {
        if (error is ServerException) {
        if (error.statusCode == 401) {
          emit(RedeemUI(isLoading: false, action: NeedAuthAction(phoneNumber: phoneNumber)));
          return;
        }
        }
        emit(RedeemUI(isLoading: false, error: error.toString()));
      },
      (response) {
        emit(RedeemUI(isLoading: false, action: GoSuccessAction(phoneNumber: phoneNumber)));
      }
    );
  }
}
