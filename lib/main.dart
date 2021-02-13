import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

const double spacer = 15;
const Color color1 = Color(0xFFFFB1A4);
const Color color2 = Color(0xFFFDE6BD);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: RecipeHomePage(),
    );
  }
}

class RecipeHomePage extends StatelessWidget {
  RecipeHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: spacer * 3),
                      HeaderWidget(),
                      SizedBox(height: spacer * 2.5),
                      CarouselWidget(),
                      SizedBox(height: spacer),
                      buildShareText(),
                      SizedBox(height: spacer),
                      CategoriesWidget(),
                      SizedBox(height: spacer),
                      PillListWidget(),
                      SizedBox(height: spacer * 2),
                    ],
                  ),
                ),
              ),
              BottomNavWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Text buildShareText() {
    return Text(
      "LET'S SHARE SOME RECIPES",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 6,
      itemBuilder: (context, index, _) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                image: AssetImage("assets/images/img0${index + 1}.jpg"),
                fit: BoxFit.cover,
              )),
        );
      },
      options: CarouselOptions(
        scrollPhysics: AlwaysScrollableScrollPhysics(),
        viewportFraction: 0.8,
        enlargeCenterPage: true,
      ),
    );
  }
}

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.home, color: color1, size: 30),
              SizedBox(width: 30),
              Icon(Icons.broken_image_outlined, color: color1, size: 30),
            ],
          ),
          Positioned(
            top: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.5),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color2,
                ),
                child: Transform.rotate(angle: 3.14 / 4, child: Icon(Icons.close, size: 50, color: Colors.red)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spacer * 2),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: spacer / 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: color1, size: 30),
                  hintText: "Buscar",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(Icons.more_vert, color: color1, size: 30),
          ),
        ],
      ),
    );
  }
}

class CategoriesWidget extends HookWidget {
  CategoriesWidget({Key key}) : super(key: key);

  final List<String> categories = [
    "Italian",
    "Mexican",
    "Japanesse",
    "Peruvian",
    "Chinesse",
  ];

  @override
  Widget build(BuildContext context) {
    final selected = useState(categories[0]);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: categories
            .map(
              (category) => InkWell(
                onTap: () => selected.value = category,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: category == selected.value ? color2.withGreen(190) : Colors.white,
                  ),
                  child: Text(
                    category,
                    style: TextStyle(color: category == selected.value ? Colors.white : color1),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class PillListWidget extends HookWidget {
  PillListWidget({Key key}) : super(key: key);
  //this is the list of images that we have on assets, but we only need last numbers to complete our asset directions.

  final items = [
    RecipeItem("Lasagna", 4.9, "Ernesto", "2", "easy", 1),
    RecipeItem("Pizza", 4.1, "Presto", "1", "easy", 2),
    RecipeItem("Rissoto", 4.2, "El Pepe", "2", "medium", 3),
    RecipeItem("Ceviche", 5.1, "Gaston", "2", "hard", 4),
    RecipeItem("Chilcano", 5.2, "Olga", "2", "hard", 5),
    RecipeItem("Amborguesa", 2.3, "Raul", "2", "hard", 6)
  ];

  @override
  Widget build(BuildContext context) {
    final selected = useState(-1);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (item) => InkWell(
                onTap: () => selected.value = selected.value == item.pos ? -1 : item.pos,
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  height: selected.value == item.pos ? 260 : 200,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    // color: selected.value == item.pos ? Colors.red : Colors.white,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 107,
                              height: 153,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: item.pos == selected.value ? color2 : Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/img0${item.pos}.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              child: Icon(Icons.star, color: Colors.yellow),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          item.name,
                          style: TextStyle(
                            color: color1,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${item.punctuation}",
                          style: TextStyle(color: color1, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Visibility(
                          visible: selected.value == item.pos,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: color1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.person, color: Colors.white, size: 12),
                                    SizedBox(width: 5),
                                    Text(item.chiefName, style: TextStyle(color: Colors.white, fontSize: 12)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.alarm, color: color1, size: 12),
                                  SizedBox(width: 5),
                                  Text("${item.time} hours", style: TextStyle(color: color1, fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.settings_phone_rounded, color: color1, size: 12),
                                  SizedBox(width: 5),
                                  Text(item.level, style: TextStyle(color: color1, fontSize: 12)),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class RecipeItem {
  final String name;
  final double punctuation;
  final String chiefName;
  final String time;
  final String level;
  final int pos;

  RecipeItem(this.name, this.punctuation, this.chiefName, this.time, this.level, this.pos);
}
