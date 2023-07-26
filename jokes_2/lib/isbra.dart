import 'package:flutter/material.dart';
import 'package:jokes_2/mi/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class Tin extends StatefulWidget {
  const Tin({super.key, });
  @override
  State<Tin> createState() => _TinState();

}

class _TinState extends State<Tin> {
  
  final translator = GoogleTranslator();
 SharedPreferences? pre;

 List<String> isb = [];

  void initPag() async {
 pre = await SharedPreferences.getInstance();

 isb = pre!.getStringList('List') ?? [];
 setState(() {
   
 });

 print(isb);

  }

  @override
  void initState() {
    initPag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: const Text(
          'Избранные',
          style: Fonts.s25w700,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.white,
          ),
          itemCount: isb.length,
          itemBuilder: ((context, index) => ListTile(
                title: Text(
                  isb[index],
                  style: Fonts.s20w600,
                ),
               
                subtitle: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          isb.removeAt(index);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await translator
                            .translate(isb[index].toString(), to: 'en')
                            .then((value) =>
                                isb[index] = value.toString());
                        setState(() {});
                      },
                      child: Text(
                        'EN',
                        style: Fonts.s25w700.copyWith(fontSize: 22),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextButton(
                      onPressed: () async {
                        await translator
                            .translate(isb[index].toString(), to: 'ky')
                            .then((value) =>
                                isb[index] = value.toString());
                        setState(() {});
                      },
                      child: Text(
                        'KG',
                        style: Fonts.s25w700.copyWith(fontSize: 22),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextButton(
                      onPressed: () async {
                        await translator
                            .translate(isb[index].toString(), to: 'ru')
                            .then((value) =>
                                isb[index] = value.toString());
                        setState(() {});
                      },
                      child: Text(
                        'Ru',
                        style: Fonts.s25w700.copyWith(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
