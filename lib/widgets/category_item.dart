import 'package:flutter/material.dart';
import 'package:newsapp/views/category_news.dart';

class CategoryItem extends StatelessWidget {
  final String categoryTitle, imageUrl;

  const CategoryItem({
    Key key,
    @required this.categoryTitle,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(category: categoryTitle,)));
      },
      child: Container(
          margin: EdgeInsets.only(left: 12.0),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  height: 60.0,
                  width: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 60.0,
                width: 120.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  categoryTitle,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )),
    );
  }
}