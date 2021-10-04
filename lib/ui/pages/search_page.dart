part of 'pages.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_page';
  final String query;
  const SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: defaultPaddingHorizontal,
            vertical: defaultPaddingVertical),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: SvgPicture.asset(
                        'assets/icons/Icon_left_outline.svg',
                      ),
                    ),
                  ),
                  SizedBox(width: defaultPaddingHorizontal),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You Search',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        query,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<List>(
                future: RestaurantService.searchRestaurants(query),
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
            ],
          ),
        ),
      ),
    );
  }
}
