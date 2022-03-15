import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Stack;
import 'package:rokeet/core.dart';

import 'errors.dart';
import 'model.dart';
import 'network/network.dart';
import 'registry.dart';
import 'stack.dart';

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
  Rokeet._(String baseUrl, RokeetConfig config) {
    api = RokeetApiBuilder(baseUrl)
        .addInterceptor(LogInterceptor(requestBody: true, responseBody: true))
        .build();
    _configure(config);
  }

  @visibleForTesting
  Rokeet();

  late RokeetConfig _config;
  @visibleForTesting
  late RokeetApi api;

  @visibleForTesting
  final Registry<RWidgetBuilder> widgetBuilderRegistry =
      WidgetBuilderRegistry();
  @visibleForTesting
  final Registry<RActionPerformer> actionPerformerRegistry =
      ActionPerformerRegistry();

  Stack<RState> _stateStack = Stack();
  Stack<BuildContext> _contextStack = Stack();

  RState get currentState => _stateStack.top;

  BuildContext get currentContext => _contextStack.top;

  bool get isLoading {
    return api.isLoading;
  }

  void _configure(RokeetConfig config) {
    _config = config;
    config.widgetBuilders?.entries
        .forEach((e) => _registerWidgetBuilder(e.key, e.value));
    config.actionPerformers?.entries
        .forEach((e) => _registerActionPerformer(e.key, e.value));
  }

  void _registerWidgetBuilder(String key, RWidgetBuilder builder) {
    widgetBuilderRegistry.register(key, builder);
  }

  void _registerActionPerformer(String key, RActionPerformer performer) {
    actionPerformerRegistry.register(key, performer);
  }

  Future<AppConfig?> init(RState initState, BuildContext context) async {
    pushState(initState);
    pushContext(context);
    return _init();
  }

  Future<AppConfig?> _init() async {
    return await api.getApp(_config.clientId!, _config.clientSecret!);
  }

  Future<RStep?> getStep(String id) async {
    return api.getStep(id);
  }

  void pushState(RState state) => _stateStack.push(state);

  void pushContext(BuildContext context) => _contextStack.push(context);

  void popState() => _stateStack.pop;

  void popContext() => _contextStack.pop;

  void performAction(RAction action) {
    var type = action.type;

    if (type == null) {
      throw IllegalStateError("Action type must not be null");
    }

    RActionPerformer? possiblePerformer = actionPerformerRegistry.get(type);
    if (possiblePerformer == null) {
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
    RWidgetBuilder? builder = widgetBuilderRegistry.get(uiType);

    if (builder == null) {
      log('Builder for $uiType not found');
      return null;
    }
    return builder.build(this, widget);
  }
}

class RokeetBuilder {
  String? _baseUrl;
  RokeetConfig? _config;

  RokeetBuilder();

  RokeetBuilder withBaseUrl(String baseUrl) {
    this._baseUrl = baseUrl;
    return this;
  }

  RokeetBuilder withConfig(RokeetConfig config) {
    this._config = config;
    return this;
  }

  Rokeet build() {
    if (_baseUrl == null || _baseUrl?.isEmpty == true) {
      throw NoBaseUrlDefinedError();
    }

    if (_config == null) {
      _config = RokeetConfig();
    }
    return Rokeet._(this._baseUrl!, this._config!);
  }
}
