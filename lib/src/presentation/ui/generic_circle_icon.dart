import 'package:flutter/material.dart';

class GenericCircleIcons extends StatelessWidget {
  final bool? isDarkTheme;
  final VoidCallback onhandle;
  final IconData customIcon;

  const GenericCircleIcons({
    super.key,
    this.isDarkTheme,
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkTheme == true
              ? const Color.fromRGBO(255, 224, 223, 0.1)
              : const Color.fromRGBO(210, 200, 200, 0.3),

          // color: Color.fromRGBO(255, 224, 223, 0.1),
        ),
        child: Icon(
          customIcon,
          color: isDarkTheme == true ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
