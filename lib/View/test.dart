import 'package:flutter/material.dart';
import 'package:pas_project_2022/Model/ProductModel.dart';
// import http
import 'package:http/http.dart' as http;
import 'dart:convert';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  ProductModel? productModel;
  bool isloaded = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    setState(() {
      isloaded = false;
    });
    final res =
        await http.get(Uri.parse('https://api.storerestapi.com/products'));
    print("status code: ${res.statusCode}");
    if (res.statusCode == 200) {
      productModel = ProductModel.fromJson(jsonDecode(res.body));
      print(productModel!.data![0].title);
      setState(() {
        isloaded = true;
      });
    } else {
      throw Exception('Failed to load data');
    }
    // productModel = ProductModel.fromJson(json.decode(res.body.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
      ),
      body: isloaded
          ? ListView.builder(
              itemCount: productModel!.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productModel!.data![index].title!),
                );
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
