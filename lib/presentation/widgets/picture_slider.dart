import 'package:flutter/material.dart';

class SondyaPictureSlider extends StatefulWidget {
  final List<dynamic> pictureList;
  const SondyaPictureSlider({super.key, required this.pictureList});

  @override
  State<SondyaPictureSlider> createState() => _SondyaPictureSliderState();
}

class _SondyaPictureSliderState extends State<SondyaPictureSlider> {
  late Map<String, dynamic> currentImage;

  @override
  void initState() {
    super.initState();
    if (widget.pictureList.isNotEmpty) {
      currentImage = widget.pictureList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black38,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(2),
          child: currentImage.isNotEmpty
              ? FadeInImage(
                  placeholder: const AssetImage(
                    'assets/images/placeholder.jpg',
                  ),
                  image: NetworkImage(currentImage["url"]),
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                )
              : const Text("No Image"),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.pictureList.length,
            itemBuilder: (context, index) {
              if (widget.pictureList.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentImage = widget.pictureList[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: currentImage == widget.pictureList[index]
                                ? const Color(0xFFEDB842)
                                : Colors.black38,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(2),
                      child: Image(
                        image: NetworkImage(widget.pictureList[index]["url"]),
                        fit: BoxFit.cover,
                        width: 50,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
