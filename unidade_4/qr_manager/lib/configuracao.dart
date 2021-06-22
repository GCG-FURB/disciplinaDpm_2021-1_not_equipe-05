import 'package:flutter/material.dart';

class Configuracao extends StatefulWidget {
  static double correctionLevel = 1;

  Configuracao({Key key}) : super(key: key) {}

  @override
  _ConfiguracaoState createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  /*void _showConfigDialog() async {
    // <-- note the async keyword here

    // this will contain the result from Navigator.pop(context, result)
    final valorSelecionado = await showDialog<double>(
      context: context,
      builder: (context) => ConfigDialog(),
    );

    // execution of this code continues when the dialog was closed (popped)

    // note that the result can also be null, so check it
    // (back button or pressed outside of the dialog)
    if (valorSelecionado != null) {
      setState(() {
        Configuracao.correctionLevel = valorSelecionado;
        // debugPrint(_currentSliderValue.toString());
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Configurações"),
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(child: Column(children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text("Nível de correção dos QrCodes gerados")),
            Container(
              child: Slider(
                value: Configuracao.correctionLevel,
                min: 1,
                max: 3,
                divisions: 2,
                label: Configuracao.correctionLevel.round().toString(),
                onChanged: (value) {
                  setState(() {
                    Configuracao.correctionLevel = value;
                  });
                  debugPrint(Configuracao.correctionLevel.toString());
                },
              ),
            ),
          ],),)

        ],
      )),
    );
  }
}

class ConfigDialog extends StatefulWidget {
  /// initial selection for the slider

  const ConfigDialog({Key key}) : super(key: key);

  @override
  _ConfigDialogState createState() => _ConfigDialogState();
}

class _ConfigDialogState extends State<ConfigDialog> {
  /// current selection of the slider
  static double _sliderValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Preferências do QR Code'),
      content: Container(
          height: 300,
          width: 300,
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text('Nível de redundância')),
              Container(
                child: Slider(
                  value: _sliderValue,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _sliderValue.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
              ),
            ],
          )),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            Navigator.pop(context, _sliderValue);
          },
          child: Text('Concluído'),
        )
      ],
    );
  }
}
