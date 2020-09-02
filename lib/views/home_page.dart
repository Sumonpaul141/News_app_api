import 'package:flutter/material.dart';
import 'package:newsapp/contants/constant.dart';
import 'package:newsapp/data/data.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/services/services.dart';
import 'package:newsapp/views/full_news_page.dart';
import 'package:newsapp/widgets/category_item.dart';

import 'category_news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categoriesList = [];
  Article article;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoriesList = categories;
    getArticlesFromInternet();
  }

  getArticlesFromInternet() async {
    article = await Services.getArticle();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appName,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        elevation: 0.3,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'All News From The internet we will fetch it for you',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(color: Colors.red[600]),
                ),
              ],
            ),
            Container(
              height: double.maxFinite,
              child: ListView.builder(
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(category: categoriesList[index].categoryName,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        categoriesList[index].categoryName,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8.0),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: mWhiteColor,
                height: 80.0,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    Category category = categoriesList[index];
                    return CategoryItem(
                      categoryTitle: category.categoryName,
                      imageUrl: category.imageUrl,
                    );
                  },
                ),
              ),
              Container(
                child: _isLoading
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemCount: article.articles.length,
                        itemBuilder: (context, index) {
                          ArticleElement articles = article.articles[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullNewsPage(
                                    blogTitle: articles.title,
                                    blogUrl: articles.url,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              height: 350.0,
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    child: Image.network(
                                      articles.urlToImage,
                                      width: double.infinity,
                                      height: 250.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      articles.title,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      articles.description,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
