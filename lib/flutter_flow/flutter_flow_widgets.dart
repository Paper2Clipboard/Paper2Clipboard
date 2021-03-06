//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FFButtonOptions {
  const FFButtonOptions({
    this.textStyle = const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
    this.elevation = 1.0,
    this.height = 16.0,
    this.width = 16.0,
    this.padding = EdgeInsetsGeometry.infinity,
    this.color = Colors.blue,
    this.disabledColor = Colors.grey,
    this.disabledTextColor = Colors.black,
    this.splashColor = Colors.yellow,
    this.iconSize = 8,
    this.iconColor = Colors.green,
    this.iconPadding = EdgeInsetsGeometry.infinity,
    this.borderRadius = 2.0,
    this.borderSide = BorderSide.none,
  });

  final TextStyle textStyle;
  final double elevation;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color disabledColor;
  final Color disabledTextColor;
  final Color splashColor;
  final double iconSize;
  final Color iconColor;
  final EdgeInsetsGeometry iconPadding;
  final double borderRadius;
  final BorderSide borderSide;
}

class FFButtonWidget extends StatefulWidget {
  const FFButtonWidget({
    Key? key,
    @required this.text = "",
    required this.onPressed,
    this.icon = const Icon(Icons.abc),
    this.iconData = Icons.abc,
    required this.options,
    this.showLoadingIndicator = true,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final IconData iconData;
  final Function() onPressed;
  final FFButtonOptions options;
  final bool showLoadingIndicator;

  @override
  State<FFButtonWidget> createState() => _FFButtonWidgetState();
}

class _FFButtonWidgetState extends State<FFButtonWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: Container(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            widget.text,
            style: widget.options.textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.showLoadingIndicator
        ? () async {
            if (loading) {
              return;
            }
            setState(() => loading = true);
            try {
              await widget.onPressed();
            } catch (e) {
              print('On pressed error:\n$e');
            }
            setState(() => loading = false);
          }
        : () => widget.onPressed();

    //if (widget.icon != null || widget.iconData != null) {
    //textWidget = Flexible(child: textWidget);
    return Container(
      height: widget.options.height,
      width: widget.options.width,
      child: ElevatedButton.icon(
        icon: SizedBox
            .shrink(), //Padding(padding: widget.options.iconPadding, child: widget.icon),
        //icon: Text("a"),
        label: textWidget,
        //label: Text("hihi"),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // shape: const RoundedRectangleBorder(
          //  borderRadius: BorderRadius.circular(widget.options.borderRadius),
          //  side: widget.options.borderSide,
          // ),
          primary: widget.options.color,
          //colorBrightness:
          //    ThemeData.estimateBrightnessForColor(widget.options.color),
          //textColor: widget.options.textStyle.color,
          //disabledColor: widget.options.disabledColor,
          //disabledTextColor: widget.options.disabledTextColor,
          //elevation: widget.options.elevation,
          //splashColor: widget.options.splashColor,
        ),
      ),
      // child: RaisedButton.icon(
      //   icon: Padding(padding: widget.options.iconPadding, child: widget.icon),
      //   label: textWidget,
      //   onPressed: onPressed,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(widget.options.borderRadius),
      //     side: widget.options.borderSide,
      //   ),
      //   color: widget.options.color,
      //   colorBrightness:
      //       ThemeData.estimateBrightnessForColor(widget.options.color),
      //   textColor: widget.options.textStyle.color,
      //   disabledColor: widget.options.disabledColor,
      //   disabledTextColor: widget.options.disabledTextColor,
      //   elevation: widget.options.elevation,
      //   splashColor: widget.options.splashColor,
      // ),
      //child: Text("You lose!"),
    );
    //}

    // return Container(
    //   height: widget.options.height,
    //   width: widget.options.width,
    //   child: RaisedButton(
    //     onPressed: onPressed,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(widget.options.borderRadius),
    //       side: widget.options.borderSide,
    //     ),
    //     textColor: widget.options.textStyle.color,
    //     color: widget.options.color,
    //     colorBrightness:
    //         ThemeData.estimateBrightnessForColor(widget.options.color),
    //     disabledColor: widget.options.disabledColor,
    //     disabledTextColor: widget.options.disabledTextColor,
    //     padding: widget.options.padding,
    //     elevation: widget.options.elevation,
    //     child: textWidget,
    //   ),
    // );
  }
}
