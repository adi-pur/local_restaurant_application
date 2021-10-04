part of 'pages.dart';

class WrapperPage extends StatefulWidget {
  static const routeName = '/wrapper_page';

  const WrapperPage({Key? key}) : super(key: key);

  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: _buildPages(),
    );
  }

  Widget _bottomNavBar() {
    return BottomNavyBar(
      showElevation: false,
      selectedIndex: index,
      itemCornerRadius: 12,
      onItemSelected: (index) => setState(() => this.index = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            textAlign: TextAlign.center,
            inactiveColor: Color(0xffCBD0DF),
            activeColor: Color(0xff2DC6F2)),
        BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
            textAlign: TextAlign.center,
            inactiveColor: Color(0xffCBD0DF),
            activeColor: Color(0xff2DC6F2)),
        BottomNavyBarItem(
            icon: Icon(Icons.account_circle_rounded),
            title: Text('Profile'),
            textAlign: TextAlign.center,
            inactiveColor: Color(0xffCBD0DF),
            activeColor: Color(0xff2DC6F2))
      ],
    );
  }

  Widget _buildPages() {
    switch (index) {
      case 1:
        return FavoritePage();
      case 2:
        return ProfilePage();
      case 0:
      default:
        return HomePage();
    }
  }
}
