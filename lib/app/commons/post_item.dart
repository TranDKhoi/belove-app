import 'package:belove_app/app/commons/photo_viewer.dart';
import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/post.dart';

class PostItem extends StatefulWidget {
  const PostItem({Key? key, required this.item}) : super(key: key);
  final Post item;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: context.screenSize.width * 0.9,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  dateFormat(widget.item.createdAt!),
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(DateFormat('EEEE').format(widget.item.createdAt!)),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.item.poster!.avatar != "")
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: Image.network(
                          widget.item.poster!.avatar!,
                          fit: BoxFit.contain,
                        ).image,
                      ),
                    if (widget.item.poster!.avatar == "")
                      Image.asset(
                        "assets/images/${widget.item.poster!.gender == 0 ? "boy.png" : "girl.png"}",
                        width: 40,
                        height: 40,
                      ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.poster!.name!,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 0,
                          ),
                        ),
                        Text(
                          DateFormat.jm().format(widget.item.createdAt!),
                          style: const TextStyle(
                            fontSize: 15,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.item.title != "")
                  Text(
                    widget.item.title!,
                    style: const TextStyle(fontSize: 15),
                  ),
                if (widget.item.images != null)
                  // PhotoViewer(galleryItems: widget.item.images!),
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.push(
                                    MaterialPageRoute(
                                      builder: (_) => PhotoViewer(
                                        galleryItems: widget.item.images!,
                                        selectedIndex: i,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(widget.item.images![i]));
                          },
                          separatorBuilder: (_, i) => const SizedBox(width: 5),
                          itemCount: widget.item.images!.length),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
