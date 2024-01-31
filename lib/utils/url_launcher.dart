import 'package:url_launcher/url_launcher.dart';

Future<void> sondyaUrlLauncher(
    {required Uri url,
    LaunchMode mode = LaunchMode.externalApplication}) async {
  if (!await launchUrl(
    url,
    mode: mode,
  )) {
    throw Exception('Could not launch $url');
  }
}
