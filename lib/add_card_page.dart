import 'package:flutter/material.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:uuid/uuid.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  late var uuid;
  final String _issuerEmail = 'example@example.com';
  final String _issuerId = '3388000000022269580';
  final String _passClass = '3388000000022269580';

  String _passId = "";
  String _examplePass = "";

  @override
  void initState() {
    uuid = const Uuid();
    _passId = uuid.v1();
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
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_passClass.$_passId",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#1f2023",
            "logo": {
              "sourceUri": {
                "uri": "https://static.coinall.ltd/cdn/oksupport/asset/currency/icon/btc.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Carteira Bitcoin"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Hash"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://bitcoin.org/img/icons/logotop.svg?1693519667"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "1234",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
  }
}
