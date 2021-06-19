import 'package:flutter/material.dart';
import 'package:qr_manager/leitor.dart';
import 'dart:async';
import 'package:qr_manager/services/qrService.dart';
import 'package:qr_manager/tela_qr.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/qrService.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static StreamController<ListView> streamLista;

  @override
  void initState() {
    super.initState();

    streamLista = StreamController<ListView>();
    _createTable(context);
  }

  // static FutureBuilder feature = FutureBuilder(
  //     future: _createTable(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return snapshot.data as Widget;
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     });

  static Builder feature = retornaStream();

  // static TextEditingController personControllerNome =
  //     new TextEditingController();


  final TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static Builder retornaStream(){
    debugPrint("RetornaFeature");
    return Builder(
        builder: (BuildContext context) => StreamBuilder(
            stream: streamLista.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                debugPrint("Tem dados");
                return snapshot.data as Widget;
              } else {
                debugPrint("Não Tem dados");
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  final Widget lista = Scaffold(
      body: Container(
        child: feature,
      ),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Selecione o tipo'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text(
                                'De que maneira você deseja adicionar um QR Code?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Localização atual'),
                          onPressed: () async {
                            Position posicao;
                            await Geolocator.getCurrentPosition()
                                .then((value) => {posicao = value});
                            debugPrint(posicao.toString());
                            initializeDateFormatting("pt_BR");
                            var format = new DateFormat('dd-MM-yyyy hh:mm:ss');
                            QRDTO qrDto = QRDTO.A(
                                posicao.latitude.toString(),
                                posicao.longitude.toString(),
                                format.format(DateTime.now()));
                            createQR(qrDto).then((value) => null);
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Ler usando câmera'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LeitorQr()));
                          },
                        ),
                      ],
                    );
                  },
                );
              })));

  static void _createTable(BuildContext context) async {
    debugPrint("-CreateTable");
    List<Widget> dataTableValues = await getAllData(context);
    streamLista.add(ListView(
      padding: const EdgeInsets.all(8),
      children: dataTableValues,
    ));

  }

  static Future<List<Widget>> getAllData(BuildContext context) async {
    List<Widget> list = <Widget>[];

    List<QRDTO> qrList = await getQR();
    qrList.forEach((element) {
      Widget personEntity = GestureDetector(
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaQR(
                              lat: element.lat,
                              long: element.long,
                              id: element.id,
                              desc: element.desc,
                            )))
              },
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(child: Text('Descrição: ${element.desc}')))));
      list.add(personEntity);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Manager'),
        actions: <Widget>[
          GestureDetector(
                onTap: () {
                  debugPrint("Refresh");
                  // futureListView = _createTable(context);
                  _createTable(context);
                        // Builder(
                        // builder: (BuildContext context) => FutureBuilder(
                        //     future: _createTable(context),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         // debugPrint("Has Data");
                        //         return snapshot.data as Widget;
                        //       } else {
                        //         // debugPrint("Hasn't Data");
                        //         return Center(
                        //           child: CircularProgressIndicator(),
                        //         );
                        //       }
                        //     }));


                },
                child: Padding(padding: EdgeInsets.fromLTRB(0,0,15,0),child: Icon(Icons.refresh),),
              ),
        ],
      ),
      body: Center(child: lista),
    );
  }
}

class DataTableEntities {
  String entity;
  String json;

  DataTableEntities(this.entity, this.json);
}
