// ignore_for_file:  prefer_typing_uninitialized_variables

import 'package:facelift_constructions/constants.dart';
import 'package:facelift_constructions/log_in/phone_auth_page.dart';
import 'package:facelift_constructions/models/room.dart';
import 'package:facelift_constructions/profile/contact_page.dart';
import 'package:facelift_constructions/services/databases.dart';
import 'package:flutter/material.dart';

import '../../dialogs.dart';

class RoomScreen extends StatelessWidget {
  final name;

  final List<RoomPhotos> photos;
  const RoomScreen({Key? key, required this.photos, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _net = false;
    bool _showName = false;
    if (name == "House front") {
      _net = true;
    }
    if (name == "Exciting Elements") {
      _net = true;
      _showName = true;
    }
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 65,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(_showName ? "$name" : "$name Photos",
              style: const TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: photos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => PhotoBox(
                  photo: photos[index],
                  size: size,
                  photos: photos,
                  net: _net,
                  showName: _showName,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  name == "Living"
                      ? "Design a luxurious living room with Facelift"
                      : name == "Bathroom"
                          ? "Design a contemporary bathroom with Facelift"
                          : name == "Bedroom"
                              ? "Design a cozy bedroom with Facelift"
                              : name == "Kitchen"
                                  ? "Build a modular kitchen with Facelift"
                                  : name == "Dressing"
                                      ? "Design spacious dressing room with Facelift"
                                      : name == "House front"
                                          ? "Design a unique house front with Facelift"
                                          : name == "Exciting Elements"
                                              ? "Facelift believes in enhancing liveability and functionality of your house"
                                              : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              InkWell(
                onTap: userLogedIn
                    ? () {
                        DatabaseService()
                            .createRequest("House Room Photos", name);
                        showSimpleAnimatedDialogBox(context,
                            "More $name photos will be provided", "3.png");
                      }
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneAuthScreen()));
                      },
                child: Container(
                  width: size.width * 0.7,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: pinkColor),
                      borderRadius: BorderRadius.circular(32)),
                  child: const Center(child: Text("See More Photos")),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactScreen()));
                },
                child: Container(
                  width: size.width * 0.7,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: pinkColor),
                      color: pinkColor,
                      borderRadius: BorderRadius.circular(32)),
                  child: const Center(
                    child: Text("Contact Now"),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoBox extends StatelessWidget {
  final RoomPhotos photo;
  final bool net;
  final bool showName;
  const PhotoBox({
    Key? key,
    required this.photo,
    required this.size,
    required this.photos,
    required this.net,
    required this.showName,
  }) : super(key: key);

  final List<RoomPhotos> photos;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 12, vertical: showName ? 12 : 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.only(top: showName ? 16 : 0),
          color: showName ? Colors.black12 : Colors.transparent,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: net
                    ? Image.network(
                        photo.image,
                        fit: BoxFit.cover,
                        height: size.height * 0.5,
                        width: showName ? size.width * 0.85 : size.width,
                      )
                    : Image.asset(
                        photo.image,
                        fit: BoxFit.cover,
                        height: size.height * 0.5,
                        width: size.width,
                      ),
              ),
              showName
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 8, left: showName ? 24 : 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            photo.id,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
