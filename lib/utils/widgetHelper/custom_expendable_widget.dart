import 'package:flutter/material.dart';

class CustomExpandableContainer extends StatefulWidget {
  final Widget childWidget;
  final bool expand;
  final BuildContext context;
  final int duration;
  CustomExpandableContainer({this.context, this.childWidget, this.expand, this.duration = 500});

  @override
  CustomExpandableContainerState createState() => CustomExpandableContainerState(context, duration, expand);
}

class CustomExpandableContainerState extends State<CustomExpandableContainer> with TickerProviderStateMixin {
  final BuildContext context;
  AnimationController expandController;
  Animation<double> animation;
  int duration;
  bool expand;

  CustomExpandableContainerState(this.context, this.duration, this.expand);

// Non-widget Methods Area
  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    );
    Animation curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    if (expand) {
      expandController.forward();
    }
  }

  @override
  void didUpdateWidget(CustomExpandableContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

// Widget Methods Area
  @override
  Widget build(BuildContext context) {
    return SizeTransition(axisAlignment: 1.0, sizeFactor: animation, child: widget.childWidget);
  }
}
