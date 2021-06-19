import 'package:flutter/material.dart';
import 'package:qr_manager/leitor.dart';

import 'package:qr_manager/services/qrService.dart';
import 'package:qr_manager/tela_qr.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'gmap.dart';
import 'services/qrService.dart';




void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);
  static const String _title = 'QrCode Manager';

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
  int _selectedIndex = 0;

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

  static Builder feature = Builder(
      builder: (BuildContext context) => FutureBuilder(
          future: _createTable(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }));

  static TextEditingController personControllerNome =
      new TextEditingController();

  static TextEditingController personControllerIdade =
      new TextEditingController();

  static TextEditingController personControllerCPF =
      new TextEditingController();

  final TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // final List<Widget> _widgetOptions = <Widget>[
  //   Scaffold(
  //     body: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.all(20.0),
  //           child: TextField(
  //             key: Key('0'),
  //             controller: personControllerNome,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'Nome',
  //             ),
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.all(20.0),
  //           child: TextFormField(
  //             key: Key('1'),
  //             controller: personControllerIdade,
  //             keyboardType: TextInputType.number,
  //             inputFormatters: <TextInputFormatter>[
  //               WhitelistingTextInputFormatter.digitsOnly
  //             ],
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'Idade',
  //             ),
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.all(20.0),
  //           child: TextField(
  //             key: Key('2'),
  //             controller: personControllerCPF,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'CPF',
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       backgroundColor: Colors.blue,
  //       child: Icon(Icons.add),
  //       onPressed: () {
  //         _addPerson();
  //       },
  //     ),
  //   ),
  //   Scaffold(
  //     body: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.all(20.0),
  //           child: TextField(
  //             key: Key('3'),
  //             controller: carControllerNome,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'Nome',
  //             ),
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.all(20.0),
  //           child: TextField(
  //             key: Key('4'),
  //             controller: carControllerMarca,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'Marca',
  //             ),
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.all(20.0),
  //           child: TextFormField(
  //             controller: carControllerAnoFabricacao,
  //             key: Key('5'),
  //             keyboardType: TextInputType.number,
  //             inputFormatters: <TextInputFormatter>[
  //               WhitelistingTextInputFormatter.digitsOnly
  //             ],
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'Ano de Fabricação',
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       backgroundColor: Colors.blue,
  //       child: Icon(Icons.add),
  //       onPressed: () {
  //         _addCar();
  //       },
  //     ),
  //   ),
  //   Scaffold(
  //       body: Container(
  //         child: feature,
  //       ),
  //       floatingActionButton: Builder(
  //           builder: (context) => FloatingActionButton(
  //               child: Icon(Icons.update),
  //               onPressed: () {
  //                 Scaffold.of(context).setState(() {
  //                   feature = FutureBuilder(
  //                       future: _createTable(),
  //                       builder: (context, snapshot) {
  //                         if (snapshot.hasData) {
  //                           return snapshot.data as Widget;
  //                         } else {
  //                           return Center(
  //                             child: CircularProgressIndicator(),
  //                           );
  //                         }
  //                       });
  //                 });
  //               }))),
  // ];

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
                            await Geolocator.getCurrentPosition().then(
                                    (value) => {
                                     posicao = value
                            });
                            debugPrint(posicao.toString());
                            initializeDateFormatting("pt_BR");
                            var format = new DateFormat('dd/MM/yyyy hh:mm:ss');
                            QRDTO qrDto = QRDTO.A(posicao.latitude.toString(), posicao.longitude.toString(), format.format(DateTime.now()));
                            createQR(qrDto).then((value) => null);
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Ler usando câmera'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LeitorQr()));
                          },
                        ),
                      ],
                    );
                  },
                );
              })));

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // static void _addPerson() {
  //   createPessoa(PessoaDTO.A(personControllerNome.text,
  //       int.parse(personControllerIdade.text), personControllerCPF.text));
  // }

  // static Future<DataTable> _createTable() async {
  //   List<DataRow> dataTableValues = await _getDataTable();
  //   return DataTable(
  //     columns: const <DataColumn>[
  //       // DataColumn(
  //       //   label: Text(
  //       //     'Ex',
  //       //     style: TextStyle(fontStyle: FontStyle.italic),
  //       //   ),
  //       // ),
  //       DataColumn(
  //         label: Text(
  //           'Meus códigos QR',
  //           style: TextStyle(fontSize: 30),
  //         ),
  //         ),
  //       ),
  //     ],
  //     rows: dataTableValues,
  //   );
  // }
  //
  // static Future<List<DataRow>> _getDataTable() async {
  //   List<DataRow> list = [];
  //   List<DataTableEntities> allData = await _getAllData();
  //   allData.forEach((element) {
  //     list.add(DataRow(cells: <DataCell>[
  //       // DataCell(Text('${element.entity}')),
  //       DataCell(Text('${element.json}'))
  //     ]));
  //   });
  //   return list;
  // }

  static Future<ListView> _createTable(BuildContext context) async {
    List<Widget> dataTableValues = await getAllData(context);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: dataTableValues,
    );
  }

  static Future<List<Widget>> getAllData(BuildContext context) async {
    List<Widget> list = <Widget>[];

    List<QRDTO> qrList = await getQR();
    qrList.forEach((element) {
      GestureDetector personEntity = GestureDetector(
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
                  child: Center(
                      child: Text(
                          'Descrição: ${element.desc}')))));
      list.add(personEntity);
    });

    // List<PessoaDTO> pessoasList = await getPessoa();
    // pessoasList.forEach((element) {
    //   DataTableEntities personEntity = DataTableEntities("Pessoa",
    //       '{id: ${element.id}, nome: ${element.nome}}');
    //   list.add(personEntity);
    // });

    // List<CarroDTO> carroList = await getCarro();
    // carroList.forEach((element) {
    //   DataTableEntities carEntity = DataTableEntities("Carro",
    //       '{id: ${element.id}, nome: ${element.nome}, marca: ${element.marca}, anoDeFabricacao: ${element.anoDeFabricacao}}');
    //   list.add(carEntity);
    // });
    return list;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void _geraQRLocalizacao() {}

  static void _geraQRCamera() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Manager'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  feature = Builder(
                      builder: (BuildContext context) => FutureBuilder(
                          future: _createTable(context),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data as Widget;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }));
                },
                child: Icon(Icons.refresh),
              )),
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
