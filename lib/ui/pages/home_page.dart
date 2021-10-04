part of 'pages.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Restaurant>> _getRestaurants;
  bool onChanged = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getRestaurants = RestaurantService.getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: defaultPaddingHorizontal,
          vertical: defaultPaddingVertical),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 36,
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon:
                        SvgPicture.asset('assets/icons/Icon_menu_outline.svg'),
                    splashRadius: 20,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      'Welcome Back',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    )
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpeg'),
                  radius: 27.5,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 31),
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: TextField(
                controller: searchController,
                style: TextStyle(fontSize: 16),
                onChanged: (value) {
                  setState(() {
                    onChanged = value.length > 0;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Find your restaurant',
                  hintStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  suffixIcon: GestureDetector(
                    onTap: onChanged
                        ? () {
                            Navigator.pushNamed(context, SearchPage.routeName,
                                arguments: searchController.text);
                          }
                        : null,
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            BannerCardWidget(
                title: 'Reliable Information',
                subtitle: 'Providing restaurant information',
                imageSrc: 'assets/images/banner1.png'),
            SizedBox(height: 27),
            Text(
              'Most People Go',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: FutureBuilder<List>(
                future: _getRestaurants,
                builder: (context, snapshot) {
                  return snapshot.connectionState != ConnectionState.done
                      ? Center(child: CircularProgressIndicator())
                      : snapshot.hasData
                          ? Column(
                              children: List.generate(
                                  snapshot.data!.length,
                                  (index) => RestaurantCardWidget(
                                      restaurant: snapshot.data![index])),
                            )
                          : snapshot.hasError
                              ? Center(child: Text(snapshot.error.toString()))
                              : Text('');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
