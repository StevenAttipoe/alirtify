import 'package:flutter/material.dart';


Widget feature(String title, String url) {
  return Builder(builder: (context) {
    return Stack(
      children:[
        Container(
          margin: const EdgeInsets.only(left: 10, top: 20),
          width: MediaQuery.of(context).size.width * .95,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              url,
              fit: BoxFit.fill
            ),
          )),
          Positioned(
            bottom: 50,
            left: 35,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                  )
              ),
            ))
      ] 
    );
  });
}
