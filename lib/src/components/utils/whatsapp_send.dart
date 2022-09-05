import 'package:url_launcher/url_launcher.dart';

whatsAppSend(context, String celular, String texto) async {
  var url = "https://wa.me/$celular?text=$texto";
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw "Não foi possível carregar $url";
  }
}
