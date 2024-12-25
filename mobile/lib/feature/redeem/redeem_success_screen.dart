import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GVAppBar(title: Lt.banhcanh),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
                child: Column(children: [
                  Gap(20),
                  CircleAvatar(
                    // decoration: BoxDecoration(
                    //   color: Colors.teal,
                    //   shape: BoxShape.circle,
                    // ),
                    radius: 60,
                    child: Text(widget.phone ?? "", style: GVTextStyle.semiBold18,),
                  ),
                  Gap(8),
                  Text("100 points", style: GVTextStyle.semiBold18,),
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
                itemBuilder: (i, _) {
                  return RewardItem();
                },
                itemCount: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Text("b")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RewardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(image: AssetImage('assets/images/logo.png'), height: 50,),
        Text("data"),
        Expanded(child: SizedBox()),
        Text("100")
      ],
    );
  }
}
