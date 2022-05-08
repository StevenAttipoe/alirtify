import 'package:flutter/material.dart';

Widget newsItem(String name, String url,int likes, int comments) {
    return Builder(
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .25,
          margin: const EdgeInsets.only(right: 15.0),
          decoration: 
            const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  url,
                  width:180,
                  height: 210,
                  fit:BoxFit.cover,
                  ),
              ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            name,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 20,),
                        Row(children: [

                          const Icon(Icons.comment),
                          Text(likes.toString()),
                          const SizedBox(width: 20,),
                          const Icon(Icons.thumb_up_alt_outlined),
                          Text(comments.toString())
                        ],),
                      ],
                    ),
                  ),
                ),
                 const SizedBox(height: 50,)
            ],
          ),
        );
      }
    );
  }