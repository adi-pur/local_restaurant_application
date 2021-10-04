part of 'widgets.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCardWidget({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: restaurant.pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/small/' +
                restaurant.pictureId,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.place_outlined,
            size: 16,
            color: Colors.grey,
          ),
          Text(
            restaurant.city,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
        ],
      ),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            restaurant.rating.toDouble().toString(),
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SvgPicture.asset(
            'assets/icons/Icon_star_solid.svg',
            color: Color(0xffFDB92C),
          )
        ],
      ),
      onTap: () => Navigator.pushNamed(context, DetailPage.routeName,
          arguments: restaurant.id),
    );
  }
}
