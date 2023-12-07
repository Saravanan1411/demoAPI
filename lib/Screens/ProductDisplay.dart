import 'dart:convert';

import 'package:demoapi/Screens/ProductDescription.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/productsData.dart';


class ProductAPI extends StatefulWidget {
  const ProductAPI({super.key});

  @override
  State<ProductAPI> createState() => _ProductAPIState();
}

class _ProductAPIState extends State<ProductAPI> {
  
  late Future<List<Product>> _productData;
  
  Future<List<Product>> ProductDisplay() async{
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(response.body);
    
    return (data as List).map((e) => Product.fromJson(e)).toList();
  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productData = ProductDisplay();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("List of Products"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(

                children: [
                  FutureBuilder(
                      future: _productData,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          List<Product> list = snapshot.data!;
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDescription(productIndex: list[index],)));
                                      // movieDescription: movieList[index],
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height*0.7,
                                              width: MediaQuery.of(context).size.height*0.1,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(list[index].image.toString()),
                                                  fit: BoxFit.fill
                                                )
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(list[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                                                    Text("Price ${list[index].price.toString()}"),
                                                    Row(
                                                        children:[
                                                          Text("Rating ${list[index].rating?.rate.toString()}"),
                                                          Text("(${list[index].rating?.count.toString()})")
                                                        ]
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )


                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        }
              
              
                        return CircularProgressIndicator();
                      }
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
