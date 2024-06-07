// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewImage extends StatefulWidget {
  PageViewImage(
      {super.key,
      required this.duringsend,
      required this.imagePath,
      required this.initalindex});
  List<String> imagePath = [];
  int initalindex;
  bool duringsend;

  @override
  _PageViewImageState createState() => _PageViewImageState();
}

class _PageViewImageState extends State<PageViewImage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initalindex;
  }

  void _deleteImage(int index) {
    setState(() {
      widget.imagePath.removeAt(index);
      if (currentIndex >= widget.imagePath.length) {
        currentIndex = widget.imagePath.length - 1;
      }
    });
    if (widget.imagePath.isEmpty) {
      Get.close(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: Get.height - 200,
                width: Get.width - 30,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                top: 10,
                child: PageView.builder(
                  controller: PageController(initialPage: currentIndex),
                  itemCount: widget.imagePath.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.file(
                      File(widget.imagePath[currentIndex]),
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imagePath.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 80,
                      width: 100,
                      padding: EdgeInsets.all(2),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: widget.duringsend ? 0.5 : 1,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                  print('tap detected $index');
                                },
                                child: Image.file(
                                  height: index == currentIndex ? 100 : 80,
                                  File(widget.imagePath[index]),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          if (index == currentIndex)
                            Center(
                                child: widget.duringsend
                                    ? IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.black),
                                        onPressed: () => _deleteImage(index))
                                    : null),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Get.close(1);
              },
              child: Text(widget.duringsend ? 'Done' : ' ok')),
        ],
      ),
    );
  }
}
