import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/remote/groupchat.dart';

class GroupChatDetailsBody extends ConsumerStatefulWidget {
  final String groupId;
  const GroupChatDetailsBody({super.key, required this.groupId});

  @override
  ConsumerState<GroupChatDetailsBody> createState() =>
      _GroupChatDetailsBodyState();
}

class _GroupChatDetailsBodyState extends ConsumerState<GroupChatDetailsBody> {
  // for the search box
  String search = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final getGroupchatMembers = ref.watch(
        getGroupchatMembersProvider((groupId: widget.groupId, search: search)));
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              context.canPop()
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              Image(
                image: const NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Aquifers group chat",
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Group created by admin, yesterday at 1:17 AM",
                style: TextStyle(
                  fontSize: 14.0,
                  color: const Color(0xFFEDB842),
                  fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                ),
              ),
              const SizedBox(height: 10.0),
              getGroupchatMembers.when(
                data: (data) {
                  return RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Group members: ",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xFF222222),
                            fontFamily:
                                GoogleFonts.playfairDisplay().fontFamily,
                          ),
                        ),
                        TextSpan(
                          text: data.length.toString(),
                          style: TextStyle(
                            fontSize: 26.0,
                            color: const Color(0xFFEDB842),
                            fontFamily:
                                GoogleFonts.playfairDisplay().fontFamily,
                          ),
                        ),
                        TextSpan(
                          text: " members",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xFF222222),
                            fontFamily:
                                GoogleFonts.playfairDisplay().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CupertinoActivityIndicator(
                  radius: 20,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Members",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              TextField(
                onSubmitted: (value) {
                  setState(() {
                    search = searchController.text;
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          search = searchController.text;
                        });
                      },
                      icon: const Icon(Icons.search)),
                  hintText: "Search members",
                ),
              ),
              getGroupchatMembers.when(
                data: (data) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // print(data[index]["user_id"]);
                      return ListTile(
                        title: Text(
                            "${data[index]["user_id"]["username"]}(${data[index]["user_id"]["email"]})"),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CupertinoActivityIndicator(
                  radius: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
