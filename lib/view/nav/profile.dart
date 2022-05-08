import 'package:alirtify/view/login.dart';
import 'package:alirtify/view/subpage/update_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  var _user = FirebaseFirestore.instance;
  late List userData = [];
  late QuerySnapshot querySnapshot;



  @override
  void initState() {
    super.initState();
    getUserDeatils();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
          Container(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/icons/alirtify.png'),
                            radius: 50.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          (userData.isEmpty)
                            ? const Text("No user found")
                           : Column(children: [
                            Text(
                              userData[0]["fullName"],
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              userData[0]["email"],
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                              ),
                            ), 
                            Text(
                              userData[0]["bio"],
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                              ),
                            ),        
                           ],) ,                
                          const Text(
                            "News Feed History",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                           ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => const LoginScreen()));
                              },
                              child: const Text('Sign Out'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                            ),
                             ElevatedButton(
                              onPressed: ()  {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>  
                                    (userData.isEmpty)? UpdateProfile("Username","User bio")
                                    : UpdateProfile(
                                      userData[0]["fullName"],
                                      userData[0]["bio"]
                                    )
                                    ));
                              },
                              child: const Text('Update Profile'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                            ),
                        ]
                    )
                  )
                )
              )
          )
        );
  }
  Future<void> getUserDeatils() async {
    querySnapshot = await _user
        .collection('users')
        .doc(uid)
        .collection('info')
        .get();

    setState(() {
      userData = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}