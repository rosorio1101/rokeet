import 'package:flutter/material.dart';
import 'widget.dart';
import '../rokeet.dart';

abstract class RWidgetBuilder<W extends RWidget> {
  Widget build(Rokeet rokeet, W widget);
}

