import 'package:exam_af_quotes_api/helper/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, "favorite");
          }, icon: Icon(Icons.favorite))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: FutureBuilder(
          future: APIHelper.apiHelper.fetchQuote(),
          builder: (context, snapshot) {
            (snapshot.hasError)
                ? print(snapshot.error)
                : const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballSpinFadeLoader),
                    ),
                  );

            return (snapshot.data == null)
                ? const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: LoadingIndicator(
                            indicatorType: Indicator.ballSpinFadeLoader)))
                : ListView(
                    children: snapshot.data!.results!.map(
                      (e) {
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            visualDensity: const VisualDensity(vertical: 4),
                            title: Text(
                              "${e.author}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(e.content!),
                            trailing: IconButton(
                              onPressed: () async{
                                SharedPreferences pref =
                                await SharedPreferences.getInstance();
                                List<String> favorites =
                                    pref.getStringList("favorites") ?? [];
                                favorites.add(e.id!);
                                await pref.setStringList("favorites", favorites);
                              },
                              icon: Icon(Icons.favorite),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  );
          },
        ),
      ),
    );
  }
}
