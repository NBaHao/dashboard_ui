import 'package:dashboard_ui/home_page.dart';
import 'package:dashboard_ui/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

enum Page { home, charging, wallet, account }

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Page _currentPage = Page.home;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: switch (_currentPage) {
      Page.wallet => const Color(0xFFF6F6F6),
      _ => Colors.white,
    }));
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          children: const <Widget>[
            HomePage(),
            Center(
              child: Text('Charging Page'),
            ),
            Center(
              child: WalletPage(),
            ),
            Center(
              child: Text('Account Page'),
            ),
          ],
          onPageChanged: (int index) {
            setState(() {
              _currentPage = Page.values[index];
            });
            _pageController.jumpToPage(index);
          },
        ),
        floatingActionButton: scanQRButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: navBar(),
      ),
    );
  }

  FloatingActionButton scanQRButton() {
    return FloatingActionButton(
      onPressed: () {},
      shape: const CircleBorder(),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle, // circular shape
          gradient: LinearGradient(
            colors: [
              Color(0xFF5BAF00),
              Color(0xFF81D100),
            ],
          ),
        ),
        child: SvgPicture.asset('assets/scan.svg'),
      ),
    );
  }

  BottomAppBar navBar() {
    return BottomAppBar(
      color: Colors.white,
      height: 64,
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const Text('Bắt Đầu Sạc!',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF59AD00),
                    fontWeight: FontWeight.w500)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _currentPage = Page.home;
                      });
                      _pageController.jumpToPage(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SvgPicture.asset(_currentPage == Page.home
                            ? 'assets/home-2.svg'
                            : 'assets/home.svg'),
                        Text('Trang chủ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: _currentPage == Page.home
                                    ? FontWeight.bold
                                    : FontWeight.w400))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _currentPage = Page.charging;
                      });
                      _pageController.jumpToPage(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SvgPicture.asset(_currentPage == Page.charging
                            ? 'assets/gas-station-2.svg'
                            : 'assets/gas-station.svg'),
                        Text('Phiên sạc',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: _currentPage == Page.charging
                                    ? FontWeight.bold
                                    : FontWeight.w400))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _currentPage = Page.wallet;
                      });
                      _pageController.jumpToPage(2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SvgPicture.asset(_currentPage == Page.wallet
                            ? 'assets/empty-wallet-2.svg'
                            : 'assets/empty-wallet.svg'),
                        Text('Ví tiền',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: _currentPage == Page.wallet
                                    ? FontWeight.bold
                                    : FontWeight.w400))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _currentPage = Page.account;
                      });
                      _pageController.jumpToPage(3);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SvgPicture.asset(_currentPage == Page.account
                              ? 'assets/profile-2.svg'
                              : 'assets/profile.svg'),
                          Text('Tài khoản',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: _currentPage == Page.account
                                      ? FontWeight.bold
                                      : FontWeight.w400))
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
