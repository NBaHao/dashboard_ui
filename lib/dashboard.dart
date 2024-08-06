import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum Page { home, charging, wallet, account }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentCarIndex = 0;
  int _currentBannerIndex = 0;
  Page _currentPage = Page.home;

  Size _size = Size.zero;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSize();
    });
  }

  void _getSize() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject()! as RenderBox;
    setState(() {
      _size = renderBox.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    titleWidget(),
                    carInformationWidget(),
                  ],
                ),
              ]),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: findChargingStationWidget(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    userWalletWidget(),
                    dashboardWidget(),
                    bannerWidget(),
                    menuWidget(),
                    newsWidget(),
                  ],
                ),
              ]),
            ),
          ],
        ),
        floatingActionButton: scanQRButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: navBar(),
      ),
    );
  }

  Padding newsWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tin Tức',
            style: GoogleFonts.montserrat(
                color: const Color(0xFF444F56),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const SizedBox(height: 16),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 155 / 207,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/news.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lưu ý cần tránh khi sử dụng trụ sạc. Lưu ý cần tránh khi sử dụng trụ sạc. Lưu ý cần tránh khi sử dụng trụ sạc',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: const Color(0xFF444F56),
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset('assets/clock.svg', height: 16),
                        const SizedBox(width: 4),
                        Text('12/12/2022',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: const Color(0xFF708694),
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  Container menuWidget() {
    int padding =
        MediaQuery.of(context).orientation == Orientation.portrait ? 32 : 33;
    final double sumWidth = MediaQuery.sizeOf(context).width - padding;
    const double witdhOfItem = 110;
    int numberOfItemInRow = sumWidth ~/ witdhOfItem;
    double spacing = sumWidth % witdhOfItem / (numberOfItemInRow - 1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: spacing,
        spacing: spacing,
        children: [
          menuButton('assets/contact.svg', 'Hỗ Trợ', witdhOfItem),
          menuButton('assets/book.svg', 'Hướng Dẫn', witdhOfItem),
          menuButton('assets/ticket.svg', 'Ưu Đãi', witdhOfItem),
          menuButton('assets/message.svg', 'Phản Hồi', witdhOfItem),
          menuButton('assets/collab.svg', 'Hợp Tác', witdhOfItem),
          menuButton('assets/setting.svg', 'Cài đặt', witdhOfItem),
          menuButton('assets/setting.svg', 'Cài đặt', witdhOfItem),
          menuButton('assets/setting.svg', 'Cài đặt', witdhOfItem),
        ],
      ),
    );
  }

  Container menuButton(String image, String title, double witdhOfItem) {
    return Container(
      width: witdhOfItem,
      height: witdhOfItem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF6F6F6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image, height: 40),
          const SizedBox(height: 8),
          Text(title,
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: const Color(0xFF444F56),
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Column bannerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Khám Phá Thêm',
            style: GoogleFonts.montserrat(
                color: const Color(0xFF444F56),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 160,
          child: CarouselSlider(
            items: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/banner.png', fit: BoxFit.cover),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/banner.png', fit: BoxFit.cover),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/banner.png', fit: BoxFit.cover),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/banner.png', fit: BoxFit.cover),
                ),
              ),
            ],
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, reason) => setState(() {
                _currentBannerIndex = index;
              }),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: AnimatedSmoothIndicator(
            activeIndex: _currentBannerIndex,
            count: 4,
            effect: const ExpandingDotsEffect(
              expansionFactor: 2,
              activeDotColor: Color(0xFF708694), // green color
              dotColor: Color(0xFFF0F0F5),
              dotHeight: 4,
              dotWidth: 7,
              spacing: 5,
            ),
          ),
        ),
      ],
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

  Padding dashboardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Phiên Sạc Gần Đây',
                    style: GoogleFonts.montserrat(
                        color: const Color(0xFF444F56),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 17, color: Color(0xFF708694)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFF6F6F6),
            ),
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Audi Q8 E- Tron',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: const Color(0xFF444F56),
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text('14:40 - 12/12/2022',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: const Color(0xFF444F56),
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text('Đang sạc',
                          style: GoogleFonts.montserrat(
                              color: const Color(0xFF22AFFA),
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                      icon: SvgPicture.asset('assets/battery.svg', height: 18),
                      style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 12)),
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xFFFFFFFF)),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: const BorderSide(
                                          color: Color(0xFF22AFFA),
                                          width: 1.2))),
                          fixedSize:
                              WidgetStateProperty.all(const Size(106, 32)),
                          minimumSize: const WidgetStatePropertyAll(Size.zero)),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset('assets/flash2.svg',
                                        height: 22),
                                  ),
                                  const SizedBox(width: 4),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Column(
                                        verticalDirection:
                                            VerticalDirection.down,
                                        children: [
                                          Text('522',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 24,
                                                  color:
                                                      const Color(0xFF708694),
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      const SizedBox(width: 4),
                                      Column(
                                        verticalDirection:
                                            VerticalDirection.down,
                                        children: [
                                          Text('kWh',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xFF708694),
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text('Điện năng đã sạc',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: const Color(0xFF708694),
                                      fontWeight: FontWeight.w400))
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset('assets/clock.svg',
                                        height: 19),
                                  ),
                                  const SizedBox(width: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Column(
                                        verticalDirection:
                                            VerticalDirection.down,
                                        children: [
                                          Text('110',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 24,
                                                  color:
                                                      const Color(0xFF708694),
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      const SizedBox(width: 4),
                                      Column(
                                        verticalDirection:
                                            VerticalDirection.down,
                                        children: [
                                          Text('phút',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xFF708694),
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text('Thời gian đã sạc',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: const Color(0xFF708694),
                                      fontWeight: FontWeight.w400))
                            ],
                          ))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('EV ONE Vườn Lài',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: const Color(0xFF59AD00),
                            fontWeight: FontWeight.w600)),
                    SvgPicture.asset('assets/direct.svg', height: 28)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container userWalletWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF444E55), Color(0xFF48545B), Color(0xFF63737D)],
        ),
      ),
      height: 96,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nguyễn Thúy Kiều',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      Text('600.000đ',
                          style: GoogleFonts.montserrat(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: (96-76)/2,
            top: (96-76)/2,
            child: Image.asset('assets/logo-2.png'),
          ),
           Positioned(
            left: -1,
            top: -5,
            child: Image.asset('assets/Ellipse464.png'),
          ),
        ],
      ),
    );
  }

  Container findChargingStationWidget() {
    return Container(
      height: 80,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFFF6F6F6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/location.svg'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: const Text('Tìm trạm sạc gần đây',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF444F56),
                        fontWeight: FontWeight.w500)),
              ),
            ),
            Image.asset('assets/arrow.png')
          ],
        ),
      ),
    );
  }

  Container carInformationWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: _size.height,
      child: Stack(
        alignment: Alignment.topLeft,
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                width: double.infinity,
                child: CarouselSlider(
                  items: [
                    Container(
                      margin: EdgeInsets.only(right: _size.width),
                      child: Image.asset('assets/car_banner.png',
                          fit: BoxFit.cover),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: _size.width),
                      child: Image.asset('assets/car_banner.png',
                          fit: BoxFit.cover),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: _size.width),
                      child: Image.asset('assets/car_banner.png',
                          fit: BoxFit.cover),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: _size.width),
                      child: Image.asset('assets/car_banner.png',
                          fit: BoxFit.cover),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: _size.width),
                      child: Image.asset('assets/car_banner.png',
                          fit: BoxFit.cover),
                    ),
                  ],
                  options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, reason) => setState(() {
                      _currentCarIndex = index;
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(right: _size.width),
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentCarIndex,
                  count: 5,
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 2,
                    activeDotColor: Color(0xFF708694),
                    dotColor: Color(0xFFF0F0F5),
                    dotHeight: 6,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            key: _key,
            top: 0,
            right: 16,
            child: SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(0xFFF6F6F6),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/car.svg'),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Audi e-tron 2022zzzzzzzzz',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF444F56),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(0xFFF6F6F6),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/gas-station.svg'),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '19 phiên sạc',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF444F56),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(0xFFF6F6F6),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/flash.svg'),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '529 kWh',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF444F56),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding titleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Image(image: AssetImage('assets/logo.png')),
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: const Text('Xin Chào!',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF444F56),
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const Text('Nguyễn Thúy Kiều',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF444F56),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, right: 4),
                child: SvgPicture.asset('assets/noti.svg', height: 28),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color(0xFFDE2C00), shape: BoxShape.circle),
                  child: const Text('9',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 72;

  @override
  double get minExtent => 72;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
