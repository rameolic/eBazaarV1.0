import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/termsandcondition_notifier.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  PrivacyPolicyScreenContent createState() => PrivacyPolicyScreenContent();
}

class PrivacyPolicyScreenContent extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TermsAndConditionNotifier>(
      create: (context) =>
          TermsAndConditionNotifier(context, CommonNotifier().privacyPolicy),
      child: Consumer<TermsAndConditionNotifier>(
        builder: (context, termsAndConditionNotifier, _) => ModalProgressHUD(
            inAsyncCall: termsAndConditionNotifier.isLoading,
            child:
                (termsAndConditionNotifier.termsAndConditionResponse != null &&
                        termsAndConditionNotifier
                                .termsAndConditionResponse.content !=
                            null)
                    ? SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Html(
                          data: termsAndConditionNotifier
                              .termsAndConditionResponse.content,
                        ))
                    : (termsAndConditionNotifier.isLoading)
                        ? Container()
                        : Container(
                            child: Center(
                              child: Text(termsAndConditionNotifier
                                  .termsAndConditionResponse.message),
                            ),
                          )),
      ),
    );
  }
}
