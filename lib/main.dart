import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_app/pokemon.dart';
import 'package:pokemon_app/pokemondetail.dart';

void main() {
  runApp(MaterialApp(
    title: 'Poke app',
    home: Homepage(),
    debugShowCheckedModeBanner: false,
  ));
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  fetchData() async{
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(decodedJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub == null? Center(child: CircularProgressIndicator(),) : GridView.count(crossAxisCount: 2, children: pokeHub.pokemon.map((poke) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PokeDetail(
              pokemon: poke,
            )));
          },
          child: Hero(
            tag: poke.img,
            child: Card(
              elevation: 3.0,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(poke.img))
                    ),
                  ),
                  Text(poke.name, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                ],
              ) ,),
          ),
        ),
      )).toList(),),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.refresh),backgroundColor: Colors.cyan,),
    );
  }
}


