import 'package:exam_af_quotes_api/helper/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String? id;

  Future<String?> fetchQuoteId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? ids = pref.getStringList("favorites");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Quotes"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: FutureBuilder(
          future: APIHelper.apiHelper.fetchQuoteById(fetchQuoteId()),
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
                    children: snapshot.data!.map(
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
                            // trailing: IconButton(
                            //   onPressed: () async{
                            //     SharedPreferences pref=await SharedPreferences.getInstance();
                            //     await pref.setStringList("${e.id}", ["${e.author}","${e.content}"]);
                            //   },
                            //   icon: Icon(Icons.favorite),
                            // ),
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
