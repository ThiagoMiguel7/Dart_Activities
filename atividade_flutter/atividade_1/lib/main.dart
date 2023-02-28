import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:questao10/lugarBloc.dart';
import 'package:questao10/lugarResponse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CEP App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Buscar Lugar pelo CEP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LugarBloc bloc = LugarBloc();
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _padding(TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Entre com o CEP',
              ),
            )),
            _getLoadingStreamBuilder(),
            _padding(Container()),
            _getLugarResponseStreamBuilder(),
          ],
        ));
  }

  StreamBuilder<bool> _getLoadingStreamBuilder() {
    return StreamBuilder(
        stream: bloc.loadingSubject,
        builder: (context, snapshot) {
          var loading = snapshot.data ?? false;
          if (!loading) {
            return _padding(ElevatedButton(
              child: const Text('Buscar'),
              onPressed: () => bloc.getLugar(controller.text),
            ));
          } else {
            return _padding(const Center(child: SizedBox(
                width: 32, height: 32, child: CircularProgressIndicator())));
          }
        });
  }

  StreamBuilder<bool> _getLugarResponseStreamBuilder() {
    return StreamBuilder<bool>(
        stream: bloc.loadingSubject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var loading = snapshot.data ?? false;
            if (loading) {
              return const Text("");
            } else {
              return StreamBuilder<LugarResponse>(
                  stream: bloc.lugarResponseSubject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data ??
                          LugarResponse.withError("Nao encontrado");
                      var error = data.error;
                      if (error.isNotEmpty) {
                        return _padding(Text(error));
                      } else {
                        var lugar = data.lugar;
                        return _padding(Text(
                            "CEP: ${lugar.cep}\nLogradouro: ${lugar.logradouro}\nComplemento: ${lugar.complemento}\nBairro: ${lugar.bairro}\nLocalidade:${lugar.localidade}\nUF:${lugar.uf}\nDDD:${lugar.ddd}"));
                      }
                    } else {
                      return const Text("");
                    }
                  });
            }
          } else {
            return const Text("");
          }
        });
  }

  void _configurandoModalBottomSheet(BuildContext context, String erro) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Text("Erro na requisição.\n $erro"));
  }

  Padding _padding(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: widget,
    );
  }
}
