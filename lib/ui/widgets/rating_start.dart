part of 'widgets.dart';

class RatingStart extends StatelessWidget {
  final double rate;

  RatingStart({this.rate});
  @override
  Widget build(BuildContext context) {
    int numberOfStart = rate.round();
    return Row(
        children: List<Widget>.generate(
                5,
                (index) => Icon(
                      (index < numberOfStart)
                          ? MdiIcons.star
                          : MdiIcons.starOutline,
                      size: 16,
                      color: mainColor,
                    )) +
            [
              SizedBox(
                width: 4,
              ),
              Text(
                rate.toString(),
                style: greyFontStyle.copyWith(fontSize: 12),
              )
            ]);
  }
}
