import 'package:flutter/material.dart';

import '../../../../../core/theme/appStyles.dart';

class BuiltSearchItem extends StatelessWidget {
  const BuiltSearchItem({super.key, required this.item});
  final String item;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Row(
      spacing: width * 0.025,
      children: [
        Icon(
          Icons.history,
          size: 18,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        Expanded(
          child: Text(
            item,
            style: AppStyles.reg16White,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
