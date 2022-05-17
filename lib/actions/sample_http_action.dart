import 'package:rokeet/rokeet.dart';

class _SampleHttpResponse {
  String? value;
}

class _SampleHttpActionData {
  late String url;

  _SampleHttpActionData.empty() {
    url = "";
  }

  _SampleHttpActionData._fromJson(Map<String, dynamic> json) {
    url = json["url"] ?? "";
  }
}

class SampleHttpAction extends RAction<_SampleHttpActionData> {
  static const String TYPE = "sample_http_action";
  static final RActionParserFunction<SampleHttpAction> jsonParser =
      (json) => SampleHttpAction._fromJson(json);

  SampleHttpAction._fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  _SampleHttpActionData parseData(Map<String, dynamic> json) =>
      _SampleHttpActionData._fromJson(json);
}

class SampleHttpActionPerformer implements RActionPerformer<SampleHttpAction> {
  @override
  void performAction(Rokeet rokeet, SampleHttpAction action) async {
    final data = action.data ?? _SampleHttpActionData.empty();
    Response<_SampleHttpResponse> response =
        await rokeet.httpClient.get(data.url);
    _SampleHttpResponse body = response.body!;
    print(body.value);
  }
}
