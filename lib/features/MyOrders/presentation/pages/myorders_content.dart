import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/home_controller.dart';

@RoutePage()
class MyOrdersContentScreen extends ConsumerStatefulWidget {
  const MyOrdersContentScreen({super.key});

  @override
  ConsumerState<MyOrdersContentScreen> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<MyOrdersContentScreen> {


  @override
  void initState() {
    super.initState();
    // Future(() => ref.read(homeControllerProvider.notifier).fetchHomeBlocks());
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeControllerProvider);

    return Scaffold(
      // body: homeState.homeStates == RequestStates.loaded
      //     ? _buildContent(homeState.homeBlock!)
      //     : homeState.homeStates == RequestStates.loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : homeState.homeStates == RequestStates.error
      //     ? AppErrorWidget(
      //         onTap: () => Future(
      //           () =>
      //               ref.read(homeControllerProvider.notifier).fetchHomeBlocks(),
      //         ),
      //       )
      //     : SizedBox.shrink(),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 75.h,
      ), //+ 25.h vetrical padding in buildContentItem
      child: Column(children: [Center(child: Text('center'))]),
    );
  }
}
