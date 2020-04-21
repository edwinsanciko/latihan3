import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import './addData.dart';
import './detailpenjualan.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  // List penjualanList;
  // int count=0;
  Future<List> getData() async {
    final response = await http
        .get("http://192.168.137.13/cipenjualan/index.php/cipenjualan");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Data"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddData(),
        )),
      ),
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        // return new Text(list[i]['nama']);
        return new Container(
          padding: const EdgeInsets.all(3.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new DetailPenjualan(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Produk : ${list[i]['produk']}"),

                // trailing: GestureDetector(
                //   child: Icon(Icons.delete, color: Colors.red,),
                //   onTap: (){},
                // ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Future <http.Response> deletePenjualan(id) async {
  //   final http.Response response=await http.delete("http://192.168.43.58/apicarshop/penjualan/delete/$id");
  //   Future<List> ItemList=getData();
  //   ItemList.then((ItemList){
  //     setState((){
  //       this.
  //     })
  //   })

  // }
}
