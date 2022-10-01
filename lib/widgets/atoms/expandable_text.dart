import 'package:flutter/material.dart';

class AtomExpandableText extends StatefulWidget {
  const AtomExpandableText({
    Key? key,
    required this.text,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final int? maxLines;

  @override
  State<StatefulWidget> createState() => _AtomExpandableTextState();
}

class _AtomExpandableTextState extends State<AtomExpandableText> {
  late bool _expanded = false;

  toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggle(),
      child: Text(
        widget.text,
        style: const TextStyle(fontSize: 12),
        maxLines: _expanded ? null : widget.maxLines,
        overflow: _expanded ? null : TextOverflow.ellipsis,
      ),
    );
  }
}
