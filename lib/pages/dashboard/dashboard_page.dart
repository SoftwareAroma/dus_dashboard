import 'package:dus_dashboard/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intersperse/intersperse.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  /// [SummaryCard] cards
  List<SummaryCard> summaryCards = const <SummaryCard>[
    SummaryCard(title: 'Total Sales', value: '\$125,000'),
    SummaryCard(title: 'Sales Rate', value: '52.3%'),
    SummaryCard(title: 'Total Products', value: '1,200'),
    SummaryCard(title: 'Total Users', value: '12,000'),
    SummaryCard(title: 'Total Admins', value: '12,000'),
    SummaryCard(title: 'Total Employees', value: '12,000'),
  ];

  @override
  void initState() {
    /// fetch admins
    adminRepository.getAdminProfile();
    adminRepository.getAllAdmins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveBreakpointsData responsive = ResponsiveBreakpoints.of(context);

    return ContentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PageHeader(
            title: AppStrings.dashboardTitle.toUpperCase(),
            description: AppStrings.dashboardSummary,
          ),
          const Gap(16.0),
          if (responsive.isMobile)
            ...summaryCards
          else
            Row(
              children: summaryCards.map<Widget>((SummaryCard card) => Expanded(child: card)).intersperse(const Gap(16.0)).toList(),
            ),
          const Gap(16.0),
          const Expanded(
            child: MainChart(),
          ),

          /// Bottom card
          Card(
            shadowColor: Colors.black12,
            child: Row(
              children: <Widget>[
                /// Total sales this month
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const Gap(16.0),
                      Text(
                        AppStrings.monthSalesTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Gap(8.0),
                      Text(
                        '\$125,000',
                        style: GoogleFonts.poppins(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(16.0),
                    ],
                  ),
                ),

                /// Profit this month
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const Gap(16.0),
                      Text(
                        AppStrings.monthProfitTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Gap(8.0),
                      Text(
                        '\$125,000',
                        style: GoogleFonts.poppins(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(16.0),
                    ],
                  ),
                ),

                /// Percentage increase in sales
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const Gap(16.0),
                      Text(
                        AppStrings.percentageSalesTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Gap(8.0),
                      Text(
                        '52.3%',
                        style: GoogleFonts.poppins(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
