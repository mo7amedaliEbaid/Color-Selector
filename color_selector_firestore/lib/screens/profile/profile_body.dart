/*
import 'package:color_picker/models/users.dart';
import 'package:color_picker/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    UserDetails userDetails =
        Provider
            .of<UserProvider>(context)
            .getUser;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Column(
          children: [
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: 34,
                  height: 44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green.withOpacity(0.04)),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    userDetails.imageURL == null ? SizedBox() : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      NetworkImage(userDetails.imageURL!),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -5,
                      child: Column(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black38,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDetails.userName ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "arial",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(userDetails.email ?? ''),
                    SizedBox(
                      height: 8,
                    ),

                  ],
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}*/
