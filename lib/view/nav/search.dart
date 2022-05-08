import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:alirtify/view/widgets/search_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> allNewsItems = [];
  String searchString = "";
  bool _likedState = false;
  bool _bookedState = false;
  Color _likeIconColor = Colors.black;
  Color _bookIconColor = Colors.black;

  @override
  void initState() {
    super.initState();
    getNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                style: const TextStyle(
                  height: 0.3
                ),
                  onChanged: (value) {
                    setState(() {
                      searchString = value.toLowerCase();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search, size: 30),
                  )),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: allNewsItems.length,
                itemBuilder: (context, index) {
                  var url = Uri.parse(allNewsItems[index]['url'].toString());
                  return allNewsItems[index]['title']
                          .toLowerCase()
                          .contains(searchString)
                      ? GestureDetector(
                         onTap: (){
                                try {
                                  launchUrl(Uri.parse(allNewsItems[index]['url'].toString()));
                                } catch (e) {
                                  throw 'Could not launch url';
                                }
                              },
                        child: Container(
                            margin: const EdgeInsets.only(left: 10, top: 20),
                            width: MediaQuery.of(context).size.width * .95,
                            height: MediaQuery.of(context).size.height * 0.19,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                Container(
                                  width: width * .45,
                                  height: height * 0.9,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  child: (allNewsItems[index]['urlToImage'] ==
                                          null)
                                      ? Image.asset("assets/icons/news-icon.webp")
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            allNewsItems[index]['urlToImage'],
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                ),
                                Flexible(
                                    child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        allNewsItems[index]['title'],
                                        maxLines: 3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: (allNewsItems[index]
                                                  ['description'] ==
                                              null)
                                          ? const Text("Tap to read")
                                          : Text(
                                              allNewsItems[index]['description'],
                                              maxLines: 3,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Row(children: [
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _likedState == false
                                                    ? _likedState = true
                                                    : _likedState = false;

                                                _likedState == true
                                                    ? _likeIconColor =
                                                        const Color.fromARGB(
                                                            255, 66, 88, 125)
                                                    : _likeIconColor =
                                                        Colors.black;
                                              });
                                            },
                                            icon: Icon(Icons.thumb_up,
                                                color: _likeIconColor)),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _bookedState == false
                                                    ? _bookedState = true
                                                    : _bookedState = false;

                                                _bookedState == true
                                                    ? _bookIconColor =
                                                        const Color.fromARGB(
                                                            255, 66, 88, 125)
                                                    : _bookIconColor =
                                                        Colors.black;
                                              });
                                            },
                                            icon: Icon(Icons.book,
                                                color: _bookIconColor)),
                                        const Spacer(),
                                      ]),
                                    ),
                                    const Spacer(),
                                  ],
                                ))
                              ],
                            ),
                          ),
                      )
                      : const Text("");
                }),
            Center(
                child: allNewsItems.isEmpty == true
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.4),
                        child: const CircularProgressIndicator(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          color: Color.fromARGB(255, 170, 170, 170),
                        ),
                      )
                    : null),
          ],
        ),
      ),
    ));
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
}
