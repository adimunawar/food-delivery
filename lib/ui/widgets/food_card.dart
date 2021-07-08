part of 'widgets.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  FoodCard(this.food);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(spreadRadius: 3, blurRadius: 15, color: Colors.black12)
          ]),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                image: DecorationImage(
                    image: NetworkImage(food.picturePath), fit: BoxFit.cover)),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Text(
              food.name,
              maxLines: 1,
              style: blackFontStyle2,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 12),
              child: RatingStart(rate: food.rate))
        ],
      ),
    );
  }
}
