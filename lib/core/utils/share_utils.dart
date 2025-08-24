import 'package:ai_voting_app/core/utils/custom_snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

void shareText(BuildContext context, String heading) async {
  final result = await SharePlus.instance.share(
    ShareParams(text: heading, title: 'Check this out'),
  );

  if (!context.mounted) {
    return;
  }
  if (result.status == ShareResultStatus.success) {
    showSnackBar(context, 'Text copied to clipboard', SnackBarType.success);
  } else if (result.status == ShareResultStatus.dismissed) {
    print('Share dismissed.');
  }
}
