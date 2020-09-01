import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class Services {

   static Future<Article> getArticle() async {
    String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=db1077dc54c2404ebe8a9a54fcac119d";
    var response = await http.get(url);
    final article = articleFromJson(response.body);
    if(response.statusCode == 200){
      return article;
    }else{
      return Article();
    }

  }

   static Future<Article> getSpecificNews(String category) async {
    String url = "http://newsapi.org/v2/top-headlines?country=us&category="+category+"&apiKey=db1077dc54c2404ebe8a9a54fcac119d";
    var response = await http.get(url);
    final article = articleFromJson(response.body);
    if(response.statusCode == 200){
      return article;
    }else{
      return Article();
    }

  }





}