part of 'widgets.dart';

class BannerCardWidget extends StatelessWidget {
  final String title, subtitle, imageSrc;

  const BannerCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [secondaryColor, primaryColor]),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -17,
              bottom: -18,
              child: Opacity(
                opacity: .1,
                child: Container(
                  height: 92,
                  width: 99,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Positioned(
              right: -12,
              bottom: -18,
              child: Opacity(
                opacity: .2,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset(
                    imageSrc,
                    width: 60,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
