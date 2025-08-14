import 'package:flutter/material.dart';
import 'package:user_location_like_as_foodpanda/widget/custom_appbar.dart';

class MapSelectPage extends StatelessWidget {
  const MapSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(titleName: "Map Page"),
    );
  }
}
