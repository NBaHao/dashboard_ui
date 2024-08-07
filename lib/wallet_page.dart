import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _currentCard = 0;
  late final TabController _tabController =
      TabController(length: 4, vsync: this);

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            decoration: const BoxDecoration(color: Color(0xFFF6F6F6)),
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                CarouselSlider(
                  items: [cardWidget(), cardWidget(), cardWidget()],
                  options: CarouselOptions(
                    viewportFraction: 0.86,
                    aspectRatio: 327 / 184,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) => setState(
                      () {
                        _currentCard = index;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 16),
                  child: AnimatedSmoothIndicator(
                      activeIndex: _currentCard,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        expansionFactor: 2,
                        activeDotColor: Color(0xFF708694),
                        dotColor: Color(0xFFF0F0F5),
                        dotHeight: 5,
                        dotWidth: 8,
                        spacing: 5,
                      )),
                ),
              ],
            ),
          )
        ])),
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            size: 48 + 52,
            child: Column(
              children: [
                Container(
                  color: const Color(0xFFF6F6F6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(26, 12, 26, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lịch Sử Giao Dịch',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF444F56),
                                )),
                            TextButton.icon(
                                onPressed: () {},
                                label: Text('Lọc',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF444F56),
                                    )),
                                icon: SvgPicture.asset(
                                  'assets/Filter.svg',
                                  height: 20,
                                ),
                                style: ButtonStyle(
                                  minimumSize:
                                      WidgetStateProperty.all(const Size(0, 0)),
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0)),
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                )),
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xFFF6F6F6),
                                ),
                                child: TabBar(
                                  isScrollable: true,
                                  controller: _tabController,
                                  tabs: [
                                    tabWidget('Tất Cả', 0),
                                    tabWidget('Nạp Tiền', 1),
                                    tabWidget('Thanh Toán', 2),
                                    tabWidget('Hoàn Tiền', 3),
                                  ],
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(0xFF444F56)),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: const Color(0xFF444F56),
                                  labelStyle: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  dividerColor: Colors.transparent,
                                  padding: const EdgeInsets.all(2),
                                  tabAlignment: TabAlignment.start,
                                  splashFactory: NoSplash.splashFactory,
                                  labelPadding: EdgeInsets.zero,
                                  onTap: (index) {
                                    setState(() {
                                      _selectedTab = index;
                                    });
                                  },
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(26, 16, 26, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Tháng 02/2023',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF637782))),
                ),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
                transactionWidget('assets/paidout.svg', 'Thanh toán phiên sạc',
                    '16:09 09/02/2023', '-500.000đ', 'Thành công'),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Tháng 02/2023',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF637782))),
                ),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
                transactionWidget('assets/paidout.svg', 'Thanh toán phiên sạc',
                    '16:09 09/02/2023', '-500.000đ', 'Thành công'),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Tháng 02/2023',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF637782))),
                ),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
                transactionWidget('assets/paidout.svg', 'Thanh toán phiên sạc',
                    '16:09 09/02/2023', '-500.000đ', 'Thành công'),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Tháng 02/2023',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF637782))),
                ),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
                transactionWidget('assets/paidout.svg', 'Thanh toán phiên sạc',
                    '16:09 09/02/2023', '-500.000đ', 'Thành công'),
                transactionWidget('assets/deposit.svg', 'Nạp tiền vào ví',
                    '16:09 09/02/2023', '+1.000.000đ', 'Thành công'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tabWidget(String label, int index) {
    return SizedBox(
      height: 40,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 18,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border:
                index == _selectedTab || index == _selectedTab - 1 || index == 3
                    ? null
                    : const Border(
                        right: BorderSide(
                          color: Color.fromARGB(196, 187, 187, 198),
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
          ),
          child: Tab(
            text: label,
          ),
        ),
      ),
    );
  }

  OverflowBox cardWidget() {
    return OverflowBox(
      maxHeight: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [
            Color(0xFF444E55),
            Color(0xFF48545B),
            Color(0xFF63737D),
          ]),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/logo-wallet.svg',
                    height: 34,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '9.000.000đ',
                          style: GoogleFonts.montserrat(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1.5)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Khả dụng',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF80D200),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                '9.000.000đ',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/logo_color.svg'),
                                    const SizedBox(width: 8),
                                    Text('Nguyễn Thúy Kiều',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15))
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  minimumSize: const Size(0, 0),
                                ),
                                child: Text(
                                  'Nạp tiền',
                                  style: GoogleFonts.montserrat(
                                      color: const Color(0xFF444F56),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -50,
              bottom: 0,
              top: 0,
              child: Image.asset('assets/watermask-wallet-1.png'),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Image.asset('assets/watermask-wallet-2.png'))
          ],
        ),
      ),
    );
  }

  transactionWidget(
      String icon, String title, String time, String amount, String status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(icon, height: 50),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF444F56)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text(time,
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF444F56).withOpacity(0.6))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF444F56))),
              Text(status,
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF444F56).withOpacity(0.6))),
            ],
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: const Color(0xFF444F56).withOpacity(0.6))
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  double size;

  _StickyHeaderDelegate({required this.child, required this.size});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
