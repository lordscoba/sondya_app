import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupChatDetailsBody extends StatelessWidget {
  const GroupChatDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
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
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Group members: ",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color(0xFF222222),
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: "5",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color(0xFFEDB842),
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: " members",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color(0xFF222222),
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Members",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              const TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: "Search members",
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("User ${index + 1}"),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserItemForGroupChat extends StatelessWidget {
  const UserItemForGroupChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
