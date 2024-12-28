import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:govinh/data/extension/date_time_util.dart';
import 'package:govinh/data/model/redeem_history.dart';
import 'package:govinh/data/model/reward.dart';
import 'package:govinh/feature/user_rewards/bloc/redeem_success_cubit.dart';
import 'package:govinh/lt.dart';
import 'package:govinh/styles/gv_appbar.dart';
import 'package:govinh/styles/gv_textstyle.dart';

class RedeemSuccessScreen extends StatefulWidget {
  final String? phone;
  const RedeemSuccessScreen({super.key, required this.phone});

  @override
  State<StatefulWidget> createState() {
    return RedeemSuccessScreenState();
  }
}

class RedeemSuccessScreenState extends State<RedeemSuccessScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  RedeemSuccessCubit cubit = RedeemSuccessCubit();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // TODO improve get redeem history by shopSlug
    cubit.init("", widget.phone ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => cubit,
        child: BlocConsumer<RedeemSuccessCubit, RedeemSuccessUI>(
        listener: (context, state) {

    },
    builder: (context, ui) {
      final rewards = ui.rewards ?? [];
      final redeemHistories = ui.redeemHistories ?? [];
      return Scaffold(
        appBar: const GVAppBar(title: Lt.banhcanh),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                  child: Column(children: [
                    Text(ui.name ?? ""),
                    Gap(20),
                    CircleAvatar(
                      radius: 60,
                      child: Text(ui.phoneNumber ?? "", style: GVTextStyle.semiBold18,),
                    ),
                    Gap(8),
                    Text("${ui.points ?? "--"} điểm", style: GVTextStyle.semiBold18,),
                  ],)
              ),
              SliverToBoxAdapter(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(icon: Icon(Icons.redeem), text: "Đổi thưởng",),
                    Tab(icon: Icon(Icons.history), text: "Lịch sử"),
                  ],
                ),
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView.separated(
                  separatorBuilder: (i, _) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return RewardItem(reward: rewards[index]);
                  },
                  itemCount: rewards.length,
                ),
                ListView.separated(
                  separatorBuilder: (i, _) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return HistoryItem(history: redeemHistories[index]);
                  },
                  itemCount: redeemHistories.length,
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

class RewardItem extends StatelessWidget {
  final Reward reward;

  const RewardItem({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Image(image: AssetImage('assets/images/logo.png'), height: 50,),
          Gap(16),
          Text("${reward.name}"),
          Expanded(child: SizedBox()),
          Text("${reward.point} ${Lt.point}")
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final RedeemHistory history;

  const HistoryItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Image(image: AssetImage('assets/images/logo.png'), height: 50,),
          const Gap(16),
          const Expanded(child: SizedBox()),
          Text(formatUserFriendlyDate(history.createdAt))
        ],
      ),
    );
  }
}
