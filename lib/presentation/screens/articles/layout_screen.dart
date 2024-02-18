import 'package:flash_news/presentation/views/articles/home_view.dart';
import 'package:flash_news/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  static const name = 'layout-screen';
  final int pageIndex;

  const LayoutScreen({
    super.key,
    required this.pageIndex,
  });

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final views = const <Widget>[
    HomeView(),
    Center(
      child: Text(
        'FAVORITES',
        style: TextStyle(fontSize: 30),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: views,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
