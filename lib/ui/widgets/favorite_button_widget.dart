part of 'widgets.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({Key? key}) : super(key: key);

  @override
  _FavoriteButtonWidgetState createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
        child: Container(
          width: 38,
          height: 38,
          padding: EdgeInsets.all(8),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: isFavorite
              ? SvgPicture.asset(
                  'assets/icons/Icon_love_solid.svg',
                  color: Colors.red,
                )
              : SvgPicture.asset('assets/icons/Icon_love_outline.svg'),
        ));
  }
}
