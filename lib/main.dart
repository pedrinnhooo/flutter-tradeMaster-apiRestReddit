import 'package:flutter/material.dart';
import 'package:trademaster/bloc/search_Bloc.dart';
import 'package:trademaster/models/searchItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'TRADE MASTER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _searchBloc = SearchBloc();
  final List<SearchItem> itemsList = [];
  List<SearchItem> _foundItems = [];

  List imgList = [
    Image.asset("img8.jpeg"),
    Image.asset("img2.jpg"),
    Image.asset("img4.jpg"),
    Image.asset("img3.jpg"),
    Image.asset("img7.jpg"),
    Image.asset("img5.jpg"),
    Image.asset("img6.jpg"),
    Image.asset("img1.jpg"),
    Image.asset("img9.jpg"),
    Image.asset("img10.jpg"),
  ];

  @override
  void initState() {
    getAPI();
    _foundItems = itemsList;
    super.initState();
  }

  Future getAPI() async {
    final List<SearchItem> result =
        await _searchBloc.getAPI().then((value) => value);
    setState(() {
      itemsList.addAll(result);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<SearchItem> results = [];
    if (enteredKeyword.isEmpty) {
      results = itemsList;
    } else {
      results = itemsList
          .where((item) =>
              item.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
  }

  Widget listTheme() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _foundItems.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                      height: 15,
                      indent: 15,
                      endIndent: 15,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Título:\n\n${_foundItems[index].title}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        "Usuário:\n${_foundItems[index].fullName}",
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Column(
                        children: [
                          imgList[index],
                        ],
                      ),
                    );
                  })
              : const Text(
                  "Tema não encontrado",
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ),
        ),
      ],
    );
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Digite o nome do tema",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "logo.png",
          width: 180,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.black, Colors.blue])),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _textField(),
          const Padding(
            padding: EdgeInsets.only(top: 14, left: 12, right: 12),
            child: Text(
              "Publicações: ",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 13),
            child: listTheme(),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
