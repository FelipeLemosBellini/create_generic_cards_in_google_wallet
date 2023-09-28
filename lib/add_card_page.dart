import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final String _issuerEmail = 'exampl0e@example.com';
  final String _issuerId = '3388000000022269580';
  final String _passClass = 'idClass2';

  String _passId = "";
  String _examplePass = "";

  @override
  void initState() {
    var uuid = const Uuid();
    _passId = uuid.v1().toString();
    print(_passId);
    _setPass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AddToGoogleWalletButton(
                pass: _examplePass,
                onSuccess: () => _showSnackBar(context, 'Success!'),
                onCanceled: () => _showSnackBar(context, 'Action canceled.'),
                onError: (Object error) => _showSnackBar(context, error.toString()),
                locale: const Locale.fromSubtags(languageCode: 'pt-br', countryCode: 'BR'))));
  }

  void _showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  void _setPass() {
    //https://developers.google.com/wallet/generic/resources/pass-editor?hl=pt-br
    //https://developers.google.com/wallet/tickets/events/web?hl=pt-br
    _examplePass = """ 
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [
      'http://google.com.br'
      ],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "type": "GENERIC_PRIVATE_PASS_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#fcf526",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "no qr code"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "header"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "subheader"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "Editavel",
              "alternateText": "Editavel ou removivel"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.png",
              },
            "textModulesData": [
              {
                "header": "header",
                "body": "body",
                "id": "id"
              }
            ]
          }
        ]
      }
    }
""";
  }
}
