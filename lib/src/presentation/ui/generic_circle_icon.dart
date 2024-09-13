import 'package:flutter/material.dart';

class GenericCircleIcons extends StatelessWidget {
  final VoidCallback onhandle;
  final IconData customIcon;

  const GenericCircleIcons({
    super.key,
    required this.onhandle,
    required this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onhandle,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 224, 223, 0.1),
        ),
        child: Icon(
          customIcon,
          color: Colors.white,
        ),
      ),
    );
  }
}
