import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hcs/src/routing/app_router.gr.dart';

@RoutePage()
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeRouter = AutoRouter.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AutoRouter.of(context).replace(const MyOrdersContentRoute());
    });

    // return Scaffold(body: AutoRouter());
    return const AutoRouter();
  }
}
