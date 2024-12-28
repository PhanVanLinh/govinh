import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:govinh/data/model/redeem_history.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/feature/redeem/usecase/get_redeem_history_usecase.dart';
import 'package:govinh/feature/redeem/usecase/get_rewards_use_case.dart';

class RedeemSuccessAction {}

class GoSuccessAction extends RedeemSuccessAction {
  final String phoneNumber;

  GoSuccessAction({required this.phoneNumber});
}

class RedeemSuccessUI {
  final bool isLoading;
  final String? phoneNumber;
  final int? points;
  final int? earnPoints;
  final String? error;
  final List<Reward>? rewards;
  final List<RedeemHistory>? redeemHistories;
  final RedeemSuccessAction? action;

  RedeemSuccessUI(
      {required this.isLoading,
      this.phoneNumber,
      this.points,
      this.earnPoints,
      this.rewards,
      this.redeemHistories,
      this.error,
      this.action});

  RedeemSuccessUI copyWith({
    bool? isLoading,
    RedeemSuccessAction? action,
    String? phoneNumber,
    List<Reward>? rewards,
    List<RedeemHistory>? redeemHistories,
  }) {
    return RedeemSuccessUI(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      action: action,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      points: points,
      earnPoints: earnPoints,
      rewards: rewards ?? this.rewards,
      redeemHistories: redeemHistories ?? this.redeemHistories,
    );
  }
}

class RedeemSuccessCubit extends Cubit<RedeemSuccessUI> {
  GetRewardsUseCase getRewardsUseCase = GetRewardsUseCase();
  GetReemHistoryUseCase getReemHistoryUseCase = GetReemHistoryUseCase();

  RedeemSuccessCubit()
      : super(RedeemSuccessUI(
          isLoading: false,
        ));

  void init(String shopSlug, String phoneNumber) async {
    emit(RedeemSuccessUI(isLoading: false, phoneNumber: phoneNumber));
    (await getReemHistoryUseCase.execute(GetReemHistoryInput(shopSlug, phoneNumber))).fold((error) {

    }, (response) {
      emit(state.copyWith(
          isLoading: false,
          phoneNumber: phoneNumber,
          redeemHistories: response
      ));
    });
    (await getRewardsUseCase.execute(GetRewardsInput())).fold((error) {
    }, (response) {
      emit(state.copyWith(
          isLoading: false,
          phoneNumber: phoneNumber,
          rewards: response
      ));
    });
  }
}
