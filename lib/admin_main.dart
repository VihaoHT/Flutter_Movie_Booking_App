import 'package:flutter/material.dart';
import 'package:movie_booking_app/admin/movie/screens/movie_admin_screen.dart';
import 'package:movie_booking_app/admin/statistics/screens/statistics_admin_screen.dart';
import 'package:movie_booking_app/admin/user/screens/user_admin_screen.dart';
import 'package:movie_booking_app/core/constants/constants.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  String selectedDrawerItem = "Statistics"; // Mục được chọn mặc định
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.bgColorAdmin,
        body: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                DrawerHeader(child: Image.asset(Constants.logoPath)),
                DrawerListTile(
                  title: "Statistics",
                  imageSrc: Constants.statisticPath,
                  press: () {
                    // Cập nhật trạng thái khi mục Movie được chọn
                    setState(() {
                      selectedDrawerItem = "Statistics";
                    });
                  },
                  isSelected: selectedDrawerItem == "Statistics",
                ),
                DrawerListTile(
                  title: "Movie",
                  imageSrc: Constants.moviePath,
                  press: () {
                    // Cập nhật trạng thái khi mục Movie được chọn
                    setState(() {
                      selectedDrawerItem = "Movie";
                    });
                  },
                  isSelected: selectedDrawerItem == "Movie",
                ),
                DrawerListTile(
                  title: "User",
                  imageSrc: Constants.profilePath,
                  press: () {
                    setState(() {
                      selectedDrawerItem = "User";
                    });
                  },
                  isSelected: selectedDrawerItem == "User",
                ),
              ],
            )),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.blue,
                child: _buildSelectedContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedContent() {
    // Dựa vào trạng thái để hiển thị nội dung tương ứng
    switch (selectedDrawerItem) {
      case "Statistics":
        return const StatisticsAdminScreen();
      case "Movie":
        return const MovieAdminScreen();
      case "User":
        return const UserAdminScreen();
      default:
        return Container();
    }
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, imageSrc;
  final bool isSelected;
  final VoidCallback press;

  const DrawerListTile({
    super.key,
    required this.title,
    required this.press,
    required this.imageSrc,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Image.asset(
        imageSrc,
        color: Colors.white54,
        width: 24,
        height: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
