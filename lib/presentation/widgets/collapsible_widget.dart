import 'package:flutter/material.dart';

class CollapsibleWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isVisible;
  final double padding;
  const CollapsibleWidget(
      {super.key,
      required this.title,
      required this.child,
      this.isVisible = false,
      this.padding = 16});

  @override
  State<CollapsibleWidget> createState() => _CollapsibleWidgetState();
}

class _CollapsibleWidgetState extends State<CollapsibleWidget> {
  late bool isExpanded; // Declare isExpanded as a late variable

  @override
  void initState() {
    super.initState();
    // Initialize isExpanded with the initial value of isVisible
    isExpanded = widget.isVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Row(
            children: [
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 40,
              ),
            ],
          ),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        ),
        Visibility(
          visible: isExpanded,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: widget.padding),
            child: widget.child,
          ),
        ),
        const SizedBox(height: 10.0),
        const Divider(),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
