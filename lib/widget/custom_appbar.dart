import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget{
  final String titleName;
  const CustomAppbar({
    super.key,
    required this.titleName
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(widget.titleName,style: TextStyle(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Colors.blue,
      actions: [
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_vert)
        )
      ],
    );
  }
}
