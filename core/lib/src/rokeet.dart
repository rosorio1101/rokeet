import 'dart:developer';

import 'package:flutter/material.dart' hide Stack;
import 'package:rokeet/src/utils.dart';

import 'actions/actions.dart';
import 'errors.dart';
import 'model.dart';
import 'network/network.dart';
import 'pages/pages.dart';
import 'registry.dart';
import 'stack.dart';
import 'storage/storage.dart';
import 'widgets/widgets.dart';

class RokeetConfig {
  static const DEFAULT_INIT_STEP = "main";
  RokeetConfig(this.initStep,
      {this.clientId,
      this.clientSecret,
      this.widgetBuilders,
      this.actionPerformers,
      this.pageCreators});

  final String? clientId;
  final String? clientSecret;
  final Map<String, Map<RWidgetBuilder, RWidgetParserFunction>>? widgetBuilders;
  final Map<String, Map<RActionPerformer, RActionParserFunction>>?
      actionPerformers;
  final Map<String, RPageCreator>? pageCreators;
  final String initStep;

  static RokeetConfig defaultConfig() => RokeetConfig(DEFAULT_INIT_STEP);
}

class Rokeet {
  Rokeet._(_RokeetBuilder builder) {
    _configure(builder._config!);
    this.baseUrl = builder._baseUrl!;
    httpClient = builder._clientProvider != null
        ? builder._clientProvider!.call(this).build()
        : _buildDefaultClient();
    api = RokeetApi(httpClient);
  }

  @visibleForTesting
  Rokeet();

  static _RokeetBuilder builder() => _RokeetBuilder();

  late RokeetConfig _config;

  RokeetConfig get config => _config;

  @visibleForTesting
  late RokeetApi api;

  late HttpClient httpClient;

  @visibleForTesting
  final Registry<RWidgetBuilder> widgetBuilderRegistry =
      WidgetBuilderRegistry();
  @visibleForTesting
  final Registry<RActionPerformer> actionPerformerRegistry =
      ActionPerformerRegistry();

  @visibleForTesting
  final Registry<RPageCreator> pageCreatorRegistry = StepPageCreatorRegistry();

  Stack<RState> _stateStack = Stack();
  Stack<BuildContext> _contextStack = Stack();

  RState get currentState => _stateStack.top;

  BuildContext get currentContext => _contextStack.top;

  StorageManager _storageManager = StorageManager();

  Storage get storage => _storageManager.getStorage();

  bool get isLoading {
    return api.isLoading;
  }

  late String baseUrl;

  void _configure(RokeetConfig config) {
    _config = config;
    _config.widgetBuilders?.entries.forEach((e) => e.value.entries.forEach((w) {
          _registerWidgetBuilder(e.key, w.key);
          RWidgetParser.parsers[e.key] = w.value;
        }));
    _config.actionPerformers?.entries
        .forEach((e) => e.value.entries.forEach((a) {
              _registerActionPerformer(e.key, a.key);
              RActionParser.parsers[e.key] = a.value;
            }));

    _config.pageCreators?.entries
        .forEach((e) => _registerPageCreator(e.key, e.value));
  }

  void _registerWidgetBuilder(String key, RWidgetBuilder builder) {
    widgetBuilderRegistry.register(key, builder);
  }

  void _registerActionPerformer(String key, RActionPerformer performer) {
    actionPerformerRegistry.register(key, performer);
  }

  void _registerPageCreator(String step, RPageCreator creator) {
    pageCreatorRegistry.register(step, creator);
  }

  Future<AppConfig?> init(RState initState, BuildContext context) async {
    pushState(initState);
    pushContext(context);
    return AppConfig(_config.initStep);
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

  RPageCreator getPageCreator(String key) {
    RPageCreator? creator = pageCreatorRegistry.get(key);
    if (creator == null) {
      creator = RokeetStepPage.CREATOR;
    }
    return creator;
  }

  HttpClient _buildDefaultClient() => RokeetHttpClient.builder(this)
      .addInterceptorFactory(BaseRokeetInterceptor.factory)
      .addInterceptorFactory(RokeetLogInterceptor.factory)
      .build();

  void navigateToStep(String step, {bool force = false}) {
    final context = currentContext;
    Uri? uri;
    if (step.isUri) {
      uri = Uri.parse(step);
    } else {
      uri = Uri.parse('/step?id=$step');
    }

    if (force == true) {
      var id = uri.queryParameters['id'];
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => RokeetStepPage(
            this,
            stepId: id!,
          ),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    } else {
      Navigator.pushNamed(context, uri.toString());
    }
  }
}

class _RokeetBuilder {
  String? _baseUrl;
  RokeetConfig? _config;
  HttpClientBuilderProvider? _clientProvider;
  _RokeetBuilder();

  _RokeetBuilder withBaseUrl(String baseUrl) {
    this._baseUrl = baseUrl;
    return this;
  }

  _RokeetBuilder withConfig(RokeetConfig config) {
    this._config = config;
    return this;
  }

  _RokeetBuilder withHttpClientBuilderProvider(
      HttpClientBuilderProvider configurator) {
    this._clientProvider = configurator;
    return this;
  }

  Rokeet build() {
    if (_baseUrl == null || _baseUrl?.isEmpty == true) {
      throw NoBaseUrlDefinedError();
    }

    if (_config == null) {
      _config = RokeetConfig(RokeetConfig.DEFAULT_INIT_STEP);
    }
    return Rokeet._(this);
  }
}
