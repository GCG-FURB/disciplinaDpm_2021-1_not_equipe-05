import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/services/carroService.dart';
import 'package:flutter_app/services/personService.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static FutureBuilder feature = FutureBuilder(
      future: _createTable(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Widget;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
  static TextEditingController personControllerNome =
      new TextEditingController();
  static TextEditingController personControllerIdade =
      new TextEditingController();
  static TextEditingController personControllerCPF =
      new TextEditingController();
  static TextEditingController carControllerNome = new TextEditingController();
  static TextEditingController carControllerMarca = new TextEditingController();
  static TextEditingController carControllerAnoFabricacao =
      new TextEditingController();
  final TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextField(
              key: Key('0'),
              controller: personControllerNome,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextFormField(
              key: Key('1'),
              controller: personControllerIdade,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Idade',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextField(
              key: Key('2'),
              controller: personControllerCPF,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          _addPerson();
        },
      ),
    ),
    Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextField(
              key: Key('3'),
              controller: carControllerNome,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextField(
              key: Key('4'),
              controller: carControllerMarca,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Marca',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: carControllerAnoFabricacao,
              key: Key('5'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ano de Fabricação',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          _addCar();
        },
      ),
    ),
    Scaffold(
        body: Container(
          child: feature,
        ),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                child: Icon(Icons.update),
                onPressed: () {
                  Scaffold.of(context).setState(() {
                    feature = FutureBuilder(
                        future: _createTable(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data as Widget;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  });
                }))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static void _addPerson() {
    createPessoa(PessoaDTO.A(personControllerNome.text,
        int.parse(personControllerIdade.text), personControllerCPF.text));
  }

  static void _addCar() {
    createCarro(CarroDTO.A(carControllerNome.text, carControllerMarca.text,
        int.parse(carControllerAnoFabricacao.text)));
  }

  static Future<DataTable> _createTable() async {
    List<DataRow> dataTableValues = await _getDataTable();
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Entidade',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'JSON',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: dataTableValues,
    );
  }

  static Future<List<DataRow>> _getDataTable() async {
    List<DataRow> list = [];
    List<DataTableEntities> allData = await _getAllData();
    allData.forEach((element) {
      list.add(DataRow(cells: <DataCell>[
        DataCell(Text('${element.entity}')),
        DataCell(Text('${element.json}'))
      ]));
    });
    return list;
  }

  static Future<List<DataTableEntities>> _getAllData() async {
    List<DataTableEntities> list = <DataTableEntities>[];
    List<PessoaDTO> pessoasList = await getPessoa();
    pessoasList.forEach((element) {
      DataTableEntities personEntity = DataTableEntities("Pessoa",
          '{id: ${element.id}, nome: ${element.nome}, idade: ${element.idade}, cpf: ${element.cpf}}');
      list.add(personEntity);
    });
    List<CarroDTO> carroList = await getCarro();
    carroList.forEach((element) {
      DataTableEntities carEntity = DataTableEntities("Carro",
          '{id: ${element.id}, nome: ${element.nome}, marca: ${element.marca}, anoDeFabricacao: ${element.anoDeFabricacao}}');
      list.add(carEntity);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App - 3E'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pessoa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Carro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DataTableEntities {
  String entity;
  String json;

  DataTableEntities(this.entity, this.json);
}
