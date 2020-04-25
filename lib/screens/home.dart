import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:serene/blocs/blocs.dart';
import 'package:serene/blocs/result_state.dart';
import 'package:serene/config/constants.dart';
import 'package:serene/config/dimen.dart';
import 'package:serene/config/typography.dart';
import 'package:serene/model/category.dart';
import 'package:serene/screens/category_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  bool isPlaying = false;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(FetchCategories());
    controller = AnimationController(duration: const Duration(milliseconds: Constants.animationDuration), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color(0xFF2C2C2C)),
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
              style: AppTypography.appTitle().copyWith(color: Colors.white),
            ),
            Spacer(),
            RaisedButton.icon(
              onPressed: _onPlayButtonPressed,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: controller,
                ),
                label: AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: Constants.animationDuration),
                  child: Text(
                      isPlaying? "Pause" : "Play"
                  ),
                )
            ),
            Spacer(),
            showCategories()
          ],
        ),
      ),
    );
  }

  Widget showCategories() {
    return BlocBuilder<CategoryBloc, Result>(builder: (context, state) {
      if (state is Empty) {
        return Center(child: Text('No Categories Found'));
      }
      if (state is Loading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is Success) {
        return categoriesView(state.value);
      }
      if (state is Error) {
        return Center(child: Text('Error fetching categories'));
      }
      return Center(child: Text('No Categories Found'));
    });
  }

  Widget categoriesView(List<Category> categories) {
    List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
      const StaggeredTile.count(2, 2),
      const StaggeredTile.count(2, 2.5),
      const StaggeredTile.count(2, 2.5),
      const StaggeredTile.count(2, 2),
    ];

    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) =>
          categoryView(categories[index]),
      staggeredTileBuilder: (int index) => _staggeredTiles[index],
      mainAxisSpacing: Dimen.padding,
      crossAxisSpacing: Dimen.padding,
    );
  }

  Widget categoryView(Category category) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return CategoryDetailsPage(category: category);
      },
      closedColor: category.color,
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
                        category.icon,
                        width: 100,
                        height: 100,
                      )),
                )
              ],
            ));
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onPlayButtonPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? controller.forward()
          : controller.reverse();
    });
  }

}
