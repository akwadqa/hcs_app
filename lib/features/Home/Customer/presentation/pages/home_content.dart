import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Customer/presentation/controllers/home_controller.dart';
import 'package:hcs/features/Home/Customer/presentation/widgets/service_card.dart';
import 'package:hcs/src/manager/app_strings.dart';
import 'package:hcs/src/routing/app_router.gr.dart';
import 'package:hcs/src/shared_widgets/custom_appbar.dart';

@RoutePage()
class HomeContentScreen extends ConsumerStatefulWidget {
  const HomeContentScreen({super.key});

  @override
  ConsumerState<HomeContentScreen> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContentScreen> {
  int selectedIndex = 0;
  List<String> list = ['On Call', 'Packages', 'Deep Clean', 'Maintenance'];

  @override
  void initState() {
    super.initState();
    Future(() => ref.read(homeControllerProvider.notifier).fetchCostumers());
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
      appBar: CustomAppbar(title: 'High Class Services', isHome: true),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Text(
                context.tr(AppStrings.chooseServices),
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(fontSize: 20.sp),
              ),
            ),
            ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => context.pushRoute(CustomerRoute()),
                  child: ServiceCard(title: list[index]),
                );
              },
              separatorBuilder: (context, index) {
                return 24.verticalSpace;
              },
            ),
          ],
        ),
      ),
    );
  }
}
