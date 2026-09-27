import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final String userName;

  const DashboardPage({
    super.key,
    this.userName = "User",
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

 
  final String pledges = "TSh 8,750,000";
  final String remaining = "TSh 3,750,000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFab6005),
        foregroundColor: Colors.white,
        toolbarHeight: 100,

        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: 50,
              height: 50,
              fit:BoxFit.contain,
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Text(
                "Sherehe Management\nSystem (SMS)",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Stack(
              children: [
                const Icon(
                  Icons.notifications,
                  size: 32,
                  color: Colors.white,
                ),

                Positioned(
                  right: 0,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 15),

            const Icon(
              Icons.menu,
              size: 34,
            ),
          ],
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =========================
              // WELCOME CARD
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 250, 243),
                      Color(0xFFFFF1EC),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        color: Color(0xFFAB6005),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, ${widget.userName} 👋",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF29214F),
                            ),
                          ),

                          const SizedBox(height: 7),

                          const Text(
                            "Welcome to your Sherehe System",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFAB6000),
                            ),
                          ),
                        ],
                      ),
                    ),

                    
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              //  PLEDGES
              // =========================
              Row(
                children: [
                
                  Expanded(
                    child: DashboardCard(
                      icon: Icons.groups,
                      iconColor: Color(0XFFAB6005),
                      title: "Pledges",
                      subtitle: pledges,
                      backgroundColor:  Color.fromARGB(255, 255, 250, 243),
                      onTap: () {
                        showMessage("Pledges");
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // =========================
              // CARD + ANNOUNCEMENTS
              // =========================
              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      icon: Icons.qr_code_2,
                      iconColor: Color(0XFFAB6005),
                      title: "My Card",
                      subtitle: "View your QR card",
                      backgroundColor: Color.fromARGB(255, 255, 250, 243),
                      onTap: () {
                        showMessage("My Card");
                      },
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: DashboardCard(
                      icon: Icons.campaign,
                      iconColor: Color(0XFFAB6005),
                      title: "Announcements",
                      subtitle: "Latest updates",
                      backgroundColor: Color.fromARGB(255, 255, 250, 243),
                      onTap: () {
                        showMessage("Announcements");
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // =========================
              // LATEST ANNOUNCEMENTS
              // =========================
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.campaign,
                        color: Color(0XFFAB6005),
                        size: 27,
                      ),

                      SizedBox(width: 8),

                      Text(
                        "Latest Announcements",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF28204F),
                        ),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: () {
                      showMessage("View all");
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        color: Color(0XFFAB6005),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Announcement
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 255, 250, 243),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 248, 230, 210),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 250, 243),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.campaign,
                            color: Color(0XFFAB6005),
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Text(
                            "Karibuni wote kwenye sherehe yetu!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF29214F),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "16 Sep 2026\n\n"
                      "Tunashukuru kwa ushiriki wenu. "
                      "Endeleeni kuwa sehemu ya mafanikio "
                      "ya sherehe hii.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color(0xFF59537A),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Center(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                Color(0XFFAB6005),
                          ),
                          SizedBox(width: 8),
                          CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                Color(0xFFD0CCE0),
                          ),
                          SizedBox(width: 8),
                          CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                Color(0xFFD0CCE0),
                          ),
                          SizedBox(width: 8),
                          CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                Color(0xFFD0CCE0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // EVENT SUMMARY
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 255, 250, 243),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: Color(0XFFAB6005),
                          size: 30,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Event Summary",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF28204F),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                          child: SummaryItem(
                            icon: Icons.groups,
                            title: "Total Pledge",
                            amount: pledges,
                            color:Color(0XFFAB6005),
                          ),
                        ),

                        Container(
                          width: 1,
                          height: 75,
                          color: Colors.grey.shade300,
                        ),


                        Expanded(
                          child: SummaryItem(
                            icon: Icons.pie_chart,
                            title: "Remaining",
                            amount: remaining,
                            color: Color(0XFFAB6005),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Color(0XFFAB6005),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Pledge",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: "Card",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message page"),
      ),
    );
  }
}


// =====================================================
// DASHBOARD CARD
// =====================================================

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        height: 150,
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: iconColor.withOpacity(0.15),
          ),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: Colors.white,
                size: 27,
              ),
            ),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF28204F),
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: iconColor,
                    ),
                  ),
                ),

                Icon(
                  Icons.chevron_right,
                  color: iconColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// =====================================================
// SUMMARY ITEM
// =====================================================

class SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final Color color;

  const SummaryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),

      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 27,
          ),

          const SizedBox(height: 7),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF59537A),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            amount,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
