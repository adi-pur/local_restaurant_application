part of 'pages.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final String id;

  const DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<Restaurant>(
            future: RestaurantService.getRestaurantDetail(id),
            builder: (context, snapshot) =>
                snapshot.connectionState != ConnectionState.done
                    ? Center(child: CircularProgressIndicator())
                    : snapshot.hasData
                        ? Stack(
                            children: _buildDetail(snapshot.data!),
                          )
                        : snapshot.hasError
                            ? Center(child: Text(snapshot.error.toString()))
                            : Text(''),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPaddingHorizontal,
                  vertical: defaultPaddingVertical),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  FavoriteButtonWidget()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildDetail(Restaurant restaurant) {
    return [
      Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/medium/' +
              restaurant.pictureId,
          height: 360,
          fit: BoxFit.cover,
        ),
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 360 - 42,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultPaddingHorizontal),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${restaurant.address}, ${restaurant.city}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    restaurant.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  StarRatingWidget(rating: restaurant.rating.round()),
                  SizedBox(height: 20),
                  Text(
                    'About Restaurant',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  ExpandableText(
                    restaurant.description,
                    expandText: 'Show More',
                    linkColor: primaryColor,
                    maxLines: 5,
                    collapseOnTextTap: true,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Category',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Wrap(
                    spacing: 5,
                    children: restaurant.categories!
                        .map(
                          (category) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              category,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Menus',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Text(
                    'Foods',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) =>
                            _buildCard(restaurant.foods![index]),
                        separatorBuilder: (_, index) => SizedBox(width: 20),
                        itemCount: restaurant.foods!.length),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Drinks',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.drinks!.length,
                      itemBuilder: (_, index) =>
                          _buildCard(restaurant.drinks![index]),
                      separatorBuilder: (_, index) => SizedBox(width: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Review',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.customerReviews!.length,
                      itemBuilder: (_, index) =>
                          _buildReview(restaurant.customerReviews![index]),
                      separatorBuilder: (_, index) => SizedBox(width: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ];
  }

  Widget _buildReview(CustomerReviews customerReviews) {
    return Container(
      width: 230,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customerReviews.name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            customerReviews.date,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
          Text(
            customerReviews.review,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget _buildCard(var object) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/default_pic_food_n_drink.png',
            color: primaryColor,
            fit: BoxFit.cover,
            width: 120,
          ),
          SizedBox(height: 5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(object.name),
          ),
          Text(
            'IDR 90000',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
