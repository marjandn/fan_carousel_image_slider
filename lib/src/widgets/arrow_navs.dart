import 'package:flutter/material.dart';

class ArrawNavs extends StatelessWidget {
  const ArrawNavs({super.key, required this.goNextPage, required this.goPrevPage});

  final Function goNextPage;
  final Function goPrevPage;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
        onPressed: () => goPrevPage(),
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
      const SizedBox(
        width: 16,
      ),
      IconButton(
        onPressed: () => goNextPage(),
        icon: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    ]);
  }
}
