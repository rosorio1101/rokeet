import 'dart:developer';
import 'package:flutter/material.dart';
import 'errors.dart';
import 'network/network.dart';
import 'actions/actions.dart';
import 'pages/page.dart';
import 'widgets/widgets.dart';

class RokeetConfig {
  RokeetConfig(
      {this.clientId,
      this.clientSecret,
      this.widgetBuilders,
      this.actionPerformers});

  final String? clientId;
  final String? clientSecret;
  final Map<String, RWidgetBuilder>? widgetBuilders;
  final Map<String, RActionPerformer>? actionPerformers;
}

class Rokeet {
  static final Rokeet _instance = Rokeet._internal();
  static Map<String, RWidgetBuilder> widgetBuilders = Map();
  static Map<String, RActionPerformer> actionPerformers = Map();

  factory Rokeet() {
    return _instance;
  }

  Rokeet._internal() : api = RokeetApi("http://192.168.1.92:3000");

  RokeetConfig? _config;
  final RokeetApi? api;

  RState? currentState;
  BuildContext? currentContext;

  void _configure(RokeetConfig config) {
    _config = config;
    config.widgetBuilders?.entries
        .forEach((e) => _registerWidgetBuilder(e.key, e.value));
    config.actionPerformers?.entries
        .forEach((e) => _registerActionPerformer(e.key, e.value));
  }

  void _registerWidgetBuilder(String key, RWidgetBuilder builder) {
    widgetBuilders[key] = builder;
  }

  void _registerActionPerformer(String key, RActionPerformer performer) {
    actionPerformers[key] = performer;
  }

  static Rokeet init(RokeetConfig config, RState initState) {
    var rokeet = Rokeet();
    rokeet.currentState = initState;
    rokeet._configure(config);
    rokeet._init();
    return rokeet;
  }

  void _init() async {
    final map = Map<String, String>();
    map["client_id"] = _config!.clientId!;
    map["client_secret"] = _config!.clientSecret!;

    var data = await api?.initRokeet(map);
    currentState?.onDataLoaded(data);
  }

  void getStep(String id) async {
    var data = await api?.getStep(id, Map());
    currentState?.onDataLoaded(data);
  }

  bool isLoading() {
    if (api == null) {
      return false;
    }

    return api!.isLoading;
  }

  void performAction(RAction action) {
    Iterable<RActionPerformer> possiblePerformers = actionPerformers.entries
        .where((entry) => action.type == entry.key)
        .map((e) => e.value);

    if (possiblePerformers.isEmpty) {
      log('No performers found for ${action.type}');
      return;
    }

    possiblePerformers.forEach((performer) {
      performer.performAction(this, action);
    });
  }

  Widget buildWidget(RWidget widget) {
    if (widget.uiType == null) {
      throw IllegalStateError("Widget uiType must not be null");
    }
    Iterable<RWidgetBuilder> possibleBuilders = widgetBuilders.entries
        .where((entry) => widget.uiType == entry.key)
        .map((e) => e.value);
    if (possibleBuilders.isEmpty) {
      throw NoBuilderFoundError(widget.uiType!);
    }
    return possibleBuilders.first.build(this, widget);
  }
}
