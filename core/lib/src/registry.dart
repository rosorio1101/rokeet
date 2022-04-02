import 'actions/actions.dart';
import 'pages/page.dart';
import 'widgets/widgets.dart';

abstract class Registry<T> {
  final Map<String, T> _registryMap = Map();

  void register(String key, T value) => _registryMap[key] = value;

  T? get(String key) => _registryMap[key];
}

class WidgetBuilderRegistry extends Registry<RWidgetBuilder> {}

class ActionPerformerRegistry extends Registry<RActionPerformer> {}

class StepPageCreatorRegistry extends Registry<RPageCreator> {}
