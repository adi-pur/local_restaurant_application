part of 'widgets.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  const StarRatingWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [1, 2, 3, 4, 5]
          .map((index) => SvgPicture.asset(
                'assets/icons/Icon_star_solid.svg',
                color: index <= rating ? Color(0xffFDB92C) : Color(0xffECF0F6),
                width: 20,
              ))
          .toList(),
    );
  }
}
