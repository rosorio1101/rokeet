import '../rokeet.dart';
import 'action.dart';

abstract class RActionPerformer<A extends RAction> {
  void performAction(Rokeet rokeet, A action);
}
