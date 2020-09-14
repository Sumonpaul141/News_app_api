import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/services/services.dart';
import 'package:newsapp/views/full_news_page.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({Key key, this.category}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  Article article;
  bool _isLoading = true;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    article = await Services.getSpecificNews(widget.category);
    setState(() {
      _isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: ListView.builder(
                  itemCount: article.articles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(article.articles[index].title);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullNewsPage(
                              blogUrl: article.articles[index].url,
                              blogTitle: article.articles[index].title,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        height: 365.0,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              child: Image.network(
                                article.articles[index].urlToImage == null
                                    ? "https://www.ira-sme.net/wp-content/themes/consultix/images/no-image-found-360x260.png"
                                    : article.articles[index].urlToImage,
                                width: double.infinity,
                                height: 250.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                article.articles[index].title == null
                                    ? "Title not found for this news Post"
                                    : article.articles[index].title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                article.articles[index].description == null
                                    ? "Description not found for this news Post"
                                    : article.articles[index].description,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black54),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
