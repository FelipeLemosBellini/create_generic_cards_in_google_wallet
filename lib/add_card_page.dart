import 'package:flutter/material.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:uuid/uuid.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {

  final String _issuerEmail = 'exampl0e@example.com';
  final String _issuerId = '3388000000022269580';
  final String _passClass = 'testId';

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
                onError: (Object error) {
                  print(error.toString());
                  _showSnackBar(context, error.toString());
                },
                locale: const Locale.fromSubtags(languageCode: 'pt-br', countryCode: 'BR'))));
  }

  void _showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  void _setPass() {
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
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#ff1930",
            "logo": {
              "sourceUri": {
                "uri": "https://static.coinall.ltd/cdn/oksupport/asset/currency/icon/btc.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "cardTitle"
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
