import 'package:flutter/material.dart';

abstract class RStatelessWidget<D> extends StatelessWidget {
  RStatelessWidget({Key? key, this.id, this.data}) : super(key: key);
  final String? id;
  final D? data;
}

abstract class RStatefulWidget<D> extends StatefulWidget {
  RStatefulWidget({Key? key, this.id, this.data}) : super(key: key);

  final String? id;
  final D? data;
}