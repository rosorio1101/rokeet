import 'dart:developer';
import 'package:flutter/material.dart';
import 'errors.dart';
import 'registry.dart';
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

  factory Rokeet() {
    return _instance;
  }

  Rokeet._internal() : api = RokeetApi("http://192.168.1.92:3000");

  RokeetConfig? _config;
  final RokeetApi? api;

  final Registry<RWidgetBuilder> _widgetBuilderRegistry = WidgetBuilderRegistry();
  final Registry<RActionPerformer> _actionPerformerRegistry = ActionPerformerRegistry();

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
    _widgetBuilderRegistry.register(key, builder);
  }

  void _registerActionPerformer(String key, RActionPerformer performer) {
    _actionPerformerRegistry.register(key, performer);
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
    var type = action.type;

    if (type == null) {
      throw IllegalStateError("Action type must not be null");
    }

    RActionPerformer? possiblePerformer = _actionPerformerRegistry.get(type!);
    if(possiblePerformer == null) {
      log('Performer for $type not found');
      return;
    }

    possiblePerformer.performAction(this, action);
  }

  Widget? buildWidget(RWidget widget) {
    var uiType = widget.uiType;
    if (uiType == null) {
      throw IllegalStateError("Widget uiType must not be null");
    }
    RWidgetBuilder? builder = _widgetBuilderRegistry.get(uiType!);

    if (builder == null) {
      log('Builder for $uiType not found');
      return null;
    }
    return builder.build(this, widget);
  }
}
