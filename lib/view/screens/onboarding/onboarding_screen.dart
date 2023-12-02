import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gromart_project/main.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/screens.dart';
import 'package:gromart_project/view/widgets/main_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/onBoarding';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OnboardingScreen(),
    );
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      duration: const Duration(
        milliseconds: 300,
      ),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kPopUpColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Future setSeenOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState() {
    super.initState();
    setSeenOnboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: PageView.builder(
                controller: pageController,
                itemCount: onBoardingData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return PageViewWidget(index: index);
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentPage == onBoardingData.length - 1
                      ? Row(
                          children: [
                            MainButtonWidget(
                                buttonText: 'Get Started',
                                onPressed: () => Navigator.of(context)
                                    .pushReplacementNamed('/getStarted')),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OnBoardNavButton(
                              name: 'Skip',
                              onTap: () => Navigator.of(context)
                                  .pushReplacementNamed('/getStarted'),
                            ),
                            Row(
                              children: List.generate(onBoardingData.length,
                                  (index) => dotIndicator(index)), //
                            ),
                            OnBoardNavButton(
                              name: 'Next',
                              onTap: () {
                                pageController.nextPage(
                                  duration: const Duration(
                                    milliseconds: 400,
                                  ),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}