import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jokes_2/isbra.dart';
import 'package:jokes_2/mi/Model.dart';
import 'package:jokes_2/mi/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getJes();
    super.initState();
  }

  final translator = GoogleTranslator();
  List<String>? isb= [];
  String? tex;
  getJes() async {
    final dio = Dio();
    final response = await dio.get('https://api.chucknorris.io/jokes/random');
    final result = JokesModel.fromJson(response.data);
    tex = result.value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey.shade800,
        width: 300,
        child: ListView(
          children: [
            ListTile(
              onTap: ()async {
       

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => Tin(
                       
                        )),
                  ),
                );
              },
              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 40,
              ),
              title: const Text(
                'Избранные',
                style: Fonts.s25w700,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Шутки',
          style: Fonts.s25w700,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tex ??
                      'Извините произошло ошибка, \nПовторите ещё раз или проверьте интернет 😊',
                  style: Fonts.s20w600,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: ()async {
                final prefs = await SharedPreferences.getInstance();
prefs.setStringList('List', isb?? []);
                        isb?.add(tex?? '');
                             print(isb);

                        setState(() {});
                      },
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await translator
                            .translate(tex.toString(), to: 'en')
                            .then((value) => tex = value.toString());
                        setState(() {});
                      },
                      child: Text(
                        'EN',
                        style: Fonts.s25w700.copyWith(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextButton(
                      onPressed: () async {
                        await translator
                            .translate(tex.toString(), to: 'ky')
                            .then((value) => tex = value.toString());
                        setState(() {});
                      },
                      child: Text(
                        'KG',
                        style: Fonts.s25w700.copyWith(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextButton(
                      onPressed: () async {
                        await translator
                            .translate(tex.toString(), to: 'ru')
                            .then((value) => tex = value.toString());
                        setState(() {});
                      },
                      child: Text(
                        'Ru',
                        style: Fonts.s25w700.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60,
            width: 250,
            child: ElevatedButton(
              onPressed: getJes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white10,
              ),
              child: const Text(
                'Обновить',
                style: Fonts.s20w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
