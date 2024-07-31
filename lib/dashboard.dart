import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentCarIndex = 0;
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  16, 16, 16, kBottomNavigationBarHeight + 40),
              child: Column(
                children: [
                  titleWidget(),
                  carInformationWidget(),
                  findChargingStationWidget(),
                  userWalletWidget(),
                  dashboardWidget(),
                  bannerWidget(),
                  menuWidget(),
                  Container(
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
                      ],
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: scanQRButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: navBar()));
  }

  Container menuWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        direction: Axis.horizontal,
        children: [
          menuButton('assets/contact.svg', 'Hỗ Trợ'),
          menuButton('assets/book.svg', 'Hướng Dẫn'),
          menuButton('assets/ticket.svg', 'Ưu Đãi'),
          menuButton('assets/message.svg', 'Phản Hồi'),
          menuButton('assets/collab.svg', 'Hợp Tác'),
          menuButton('assets/setting.svg', 'Cài đặt'),
          menuButton('assets/setting.svg', 'Cài đặt'),
          menuButton('assets/setting.svg', 'Cài đặt'),
        ],
      ),
    );
  }

  Container menuButton(String image, String title) {
    return Container(
      width: 110,
      height: 110,
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
        Text(
          'Khám Phá Thêm',
          style: GoogleFonts.montserrat(
              color: const Color(0xFF444F56),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        const SizedBox(height: 18),
        CarouselSlider(
          items: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.asset('assets/banner.png', fit: BoxFit.cover),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.asset('assets/banner.png', fit: BoxFit.cover),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.asset('assets/banner.png', fit: BoxFit.cover),
            )
          ],
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, reason) => setState(() {
              _currentBannerIndex = index;
            }),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: AnimatedSmoothIndicator(
            activeIndex: _currentBannerIndex,
            count: 3,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset('assets/home.svg'),
                      const Text('Trang chủ', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset('assets/gas-station.svg'),
                      const Text('Phiên sạc', style: TextStyle(fontSize: 12))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset('assets/empty-wallet.svg'),
                      const Text('Ví tiền', style: TextStyle(fontSize: 12))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SvgPicture.asset('assets/profile.svg'),
                        const Text('Tài khoản', style: TextStyle(fontSize: 12))
                      ]),
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

  Column dashboardWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 16),
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
                            fontWeight: FontWeight.w500)),
                    icon: SvgPicture.asset('assets/battery.svg', height: 18),
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 12)),
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFFFFFFFF)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(
                                    color: Color(0xFF22AFFA), width: 1.2)))),
                  )
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                                      verticalDirection: VerticalDirection.down,
                                      children: [
                                        Text('529',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                color: const Color(0xFF708694),
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(width: 4),
                                    Column(
                                      verticalDirection: VerticalDirection.down,
                                      children: [
                                        Text('kWh',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: const Color(0xFF708694),
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
                                      verticalDirection: VerticalDirection.down,
                                      children: [
                                        Text('110',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                color: const Color(0xFF708694),
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(width: 4),
                                    Column(
                                      verticalDirection: VerticalDirection.down,
                                      children: [
                                        Text('phút',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: const Color(0xFF708694),
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
    );
  }

  Container userWalletWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
            image: AssetImage('assets/user-wallet.png'), fit: BoxFit.cover),
      ),
      height: 128,
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Nguyễn Thúy Kiều',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
                Text('600.000đ',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container findChargingStationWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
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
          Image.asset('assets/Arrow.jpg')
        ],
      ),
    );
  }

  Row carInformationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                child: CarouselSlider(
                    items: [
                      Image.asset('assets/car_banner.png', fit: BoxFit.cover),
                      Image.asset('assets/car_banner.png', fit: BoxFit.cover),
                      Image.asset('assets/car_banner.png', fit: BoxFit.cover),
                      Image.asset('assets/car_banner.png', fit: BoxFit.cover),
                      Image.asset('assets/car_banner.png', fit: BoxFit.cover),
                    ],
                    options: CarouselOptions(
                      viewportFraction: 1,
                      onPageChanged: (index, reason) => setState(() {
                        _currentCarIndex = index;
                      }),
                    )),
              ),
              const SizedBox(height: 15),
              AnimatedSmoothIndicator(
                activeIndex: _currentCarIndex,
                count: 5,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 2,
                  activeDotColor: Color(0xFF708694), // green color
                  dotColor: Color(0xFFF0F0F5),
                  dotHeight: 6,
                  dotWidth: 10,
                  spacing: 5,
                ),
              ),
            ]),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                        100) //                 <--- border radius here
                    ),
                color: Color(0xFFF6F6F6),
              ),
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/car.svg'),
            ),
            const SizedBox(height: 6),
            const Text('Audi e-tron 2022',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444F56),
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 15),
            Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                        100) //                 <--- border radius here
                    ),
                color: Color(0xFFF6F6F6),
              ),
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/gas-station.svg'),
            ),
            const SizedBox(height: 6),
            const Text('19 phiên sạc',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444F56),
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 15),
            Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                        100) //                 <--- border radius here
                    ),
                color: Color(0xFFF6F6F6),
              ),
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/flash.svg'),
            ),
            const SizedBox(height: 6),
            const Text('529 kWh',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444F56),
                    fontWeight: FontWeight.w400)),
          ],
        ))
      ],
    );
  }

  Row titleWidget() {
    return Row(
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
    );
  }
}
