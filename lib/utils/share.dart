import 'package:share_plus/share_plus.dart';

void sondyaShare(String text, {String? subject}) {
  Share.share(
    text,
    subject: subject,
  );
}
