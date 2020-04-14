import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:serene/config/assets.dart';
import 'package:serene/config/dimen.dart';
import 'package:serene/config/typography.dart';
import 'package:serene/model/Category.dart';
import 'package:serene/screens/category_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color(0xFF2C2C2C)
              /*image: DecorationImage(
              image: new ExactAssetImage(Assets.homeBackground),
              fit: BoxFit.cover,
            ),*/
              /*gradient: LinearGradient(
                colors: [Color(0xFFB5DDD1), Color(0xFFD9EFFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )*/
              ),
          child: Stack(
            children: <Widget>[contentArea()],
          )),
    );
  }

  Widget contentArea() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            top: Dimen.padding, left: Dimen.padding, right: Dimen.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Serene",
              style: AppTypography.title().copyWith(color: Colors.white),
            ),
            Spacer(),
            bottomView()
          ],
        ),
      ),
    );
  }

  Widget bottomView() {
    List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
      const StaggeredTile.count(2, 2),
      const StaggeredTile.count(2, 2.5),
      const StaggeredTile.count(2, 2.5),
      const StaggeredTile.count(2, 2),
    ];

    List<Category> _categories = <Category>[
      Category(1, "City", Color(0xFFF5B97E), Assets.city),
      Category(2, "Meditation", Color(0xFF91E7F6), Assets.meditation),
      Category(3, "Forest", Color(0xFFC592F3), Assets.forest),
      Category(4, "Rain", Color(0xFFA8E087), Assets.rain),
    ];

    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) =>
          bottomElement(_categories[index]),
      staggeredTileBuilder: (int index) => _staggeredTiles[index],
      mainAxisSpacing: Dimen.padding,
      crossAxisSpacing: Dimen.padding,
    );
  }

  Widget bottomElement(Category category) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return CategoryDetailsPage(category: category);
      },
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimen.cornerRadius),
        ),
      ),
      closedBuilder: (BuildContext context, VoidCallback callback) {
        return Container(
            decoration: BoxDecoration(color: category.color),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Dimen.padding),
                  child: Text(category.title,
                      style: AppTypography.body().copyWith(fontSize: 18)),
                ),
                Positioned(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        category.iconPath,
                        width: 100,
                        height: 100,
                      )),
                )
              ],
            ));
      },
    );
  }
}
