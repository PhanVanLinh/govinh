import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:govinh/feature/home/home_cubit.dart';
import 'package:govinh/lt.dart';
import 'package:govinh/styles/gv_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeCubit homeCubit = HomeCubit();

  @override
  void initState() {
    super.initState();
    homeCubit.home();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => homeCubit,
        child: BlocConsumer<HomeCubit, HomeUI>(
        listener: (context, state) {

    },
    builder: (context, ui) {
      return Scaffold(
        appBar: const GVAppBar(
          title: Lt.app,
        ),
        body: GridView.count(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: List.generate(ui.shops.length, (index) {
            final shop = ui.shops[index];
            return GestureDetector(
              onTap: () {
                context.go("/redeem/${shop.slug}/empty");
              },
              child: Container(
                color: Colors.blue,
                child: Center(child: Text(shop.name)),
              ),
            );
          }),
        ),
      );
    }
  ));
  }
}