import 'package:ecommerce_app/logic/themebloc/cubit/themechange_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class texts extends StatelessWidget {
  const texts(
      {super.key,
      required this.text,
      this.color,
      this.big = false,
      this.middle = false,
      this.maxline = 2});
  final String text;
  final Color? color;
  final bool big;
  final bool middle;
  final maxline;
  @override
  Widget build(BuildContext context) {
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);
    Color realcolore = color ?? (theme.isdark ? Colors.black : Colors.white);
    return Text(
      text,
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.archivo(
          color: realcolore,
          fontSize: big ? 25 : 18,
          fontWeight: big
              ? FontWeight.bold
              : middle
                  ? FontWeight.bold
                  : FontWeight.normal),
    );
  }
}
