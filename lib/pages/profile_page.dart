import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:mysnap_app/pages/services/firebase_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

//-------------------------------

class _ProfilePageState extends State<ProfilePage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth! * 0.05,
        vertical: _deviceHeight! * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          _profileImage(),
          _postGridView(),
        ],
      ),
    );
  }

//show profile image
  Widget _profileImage() {
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.30,
      width: _deviceWidth! * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          100,
        ),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(_firebaseService!.currentUser!["image"]),
        ),
      ),
    );
  }

  //get all post based on user
  Widget _postGridView() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firebaseService!.getPostsForUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List _posts = snapshot.data!.docs.map((e) => e.data()).toList();
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  Map _post = _posts[index];
                  return Container(
                      
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_post['image']),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
