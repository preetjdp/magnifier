library magnifier;

import 'dart:ui';
import 'package:flutter/material.dart';

class Magnifier extends StatefulWidget {
  final Widget child;
  final double scale;
  final Size size;
  final bool enabled;

  const Magnifier(
      {@required this.child,
      this.enabled = true,
      this.scale = 1.2,
      this.size = const Size(80, 80),
      Key key})
      : super(key: key);

  @override
  _MagnifierState createState() => _MagnifierState();
}

class _MagnifierState extends State<Magnifier> {
  Offset _magnifierPosition = Offset(0, 0);
  Matrix4 matrix = Matrix4.identity();

  @override
  void initState() {
    matrix = Matrix4.identity()..scale(widget.scale);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _magnifierSize = widget.size;
    double _scale = widget.scale;
    BorderRadius _radius = BorderRadius.circular(_magnifierSize.longestSide);

    void _onPanUpdate(DragUpdateDetails dragDetails) {
      setState(() {
        _magnifierPosition = dragDetails.globalPosition -
            dragDetails.delta -
            _magnifierSize.center(Offset.zero) / 2;
        print("POSN => " + _magnifierPosition.toString());
        final Matrix4 newMatrix = Matrix4.identity();
        final Offset centerOriginTranslation =
            Alignment.center.alongSize(_magnifierSize);
        print("CNETER Trans => " + centerOriginTranslation.toString());
        newMatrix.translate(_magnifierPosition.dx + (_magnifierSize.width / 2),
            _magnifierPosition.dy + (_magnifierSize.height / 2));
        newMatrix.scale(_scale, _scale);
        newMatrix.translate(
            -(_magnifierPosition.dx + (_magnifierSize.width / 2)),
            -(_magnifierPosition.dy + (_magnifierSize.height / 2)));
        matrix = newMatrix;
      });
    }

    print(widget.enabled);

    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        if (widget.enabled)
          Positioned(
            left: _magnifierPosition.dx,
            top: _magnifierPosition.dy,
            child: ClipRRect(
              borderRadius: _radius,
              child: GestureDetector(
                onPanUpdate: _onPanUpdate,
                child: BackdropFilter(
                  filter: ImageFilter.matrix(matrix.storage),
                  child: Container(
                    height: _magnifierSize.height,
                    width: _magnifierSize.width,
                    decoration: BoxDecoration(
                        borderRadius: _radius,
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
