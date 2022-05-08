import 'package:alirtify/view/widgets/featured.dart';
import 'package:alirtify/view/widgets/new_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<dynamic> allNewsItems = [];
  List<String> imgList = [];

  @override
  void initState() {
    super.initState();
    getNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // top: false,
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("Good Day!",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Text("Explore the world with a tap!",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                            ],
                          ),
                        ),
                        (allNewsItems.isEmpty) ?
                         Center(
                           child: Padding(
                            padding: EdgeInsets.only(top: height * 0.4),
                            child: const  CircularProgressIndicator(
                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              color: Color.fromARGB(255, 170, 170, 170),
                            ),
                        ),
                         ) :
                        Container(
                          height: height*0.7,
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              scrollDirection: Axis.vertical,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4)
                            ),
                            itemCount: allNewsItems.length,
                            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                            GestureDetector(
                              onTap: (){
                                try {
                                  launchUrl(Uri.parse(allNewsItems[itemIndex]['url'].toString()));
                                } catch (e) {
                                  throw 'Could not launch url';
                                }
                              },
                              child: Container(
                              height: height,
                              child: 
                                Column(
                                  children:[
                                  const Spacer(),
                                  Container(
                                    height: height*0.5,
                                    child: 
                                    (allNewsItems[itemIndex]["urlToImage"]==null) ? Image.asset("assets/icons/news-icon.webp")
                                    : Image.network(
                                        allNewsItems[itemIndex]['urlToImage'],
                                        fit: BoxFit.fitHeight,
                                        width:1000),
                                  ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            allNewsItems[itemIndex]["title"],
                                            maxLines: 3,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold
                                              
                                            ),
                                            ),
                                        )),
                                        const Spacer(),
                                     ]
                              ),
                            ),
                          )
                        )   
                      ),
                      ],
                    ),
                  );
          }
        ),
      ),
    );
  }

  void getNewsArticles() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=894bdbb13d184421920e41ebeff2da35';
    var response = await http.get(Uri.parse(url));

    Map<String, dynamic> map = json.decode(response.body);

    setState(() {
      allNewsItems = map["articles"];
    });
  }

  _launchURL() async {
    String url = 'https://flutterdevs.com/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

}
