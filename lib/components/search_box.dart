import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final String placeholder;
  final FocusNode focusNode;
  final Function(String text) onChangeText;
  const SearchBox(
      {Key? key,
      required this.placeholder,
      required this.focusNode,
      required this.onChangeText})
      : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            CupertinoTextField(
              placeholder: widget.placeholder,
              focusNode: widget.focusNode,
              prefix: const Icon(CupertinoIcons.search, color: Colors.black,size: 18,),
              decoration: const BoxDecoration(),
              onChanged: (textValue) {
                widget.onChangeText(textValue);
              },
            ),
          ],
        ));
  }
}
