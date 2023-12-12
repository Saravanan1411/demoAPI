import 'package:demoapi/Models/productsData.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final Product productIndex;
  const ProductDescription({super.key, required this.productIndex});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
              child: Icon(Icons.arrow_back_ios_new)
          ),
          title: Text("Product Description"),
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.productIndex.title.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width*1,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(widget.productIndex.image.toString()),
                    fit: BoxFit.fill
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Rating: ${widget.productIndex.rating?.rate.toString()}"),
                  Icon(Icons.star,color: Colors.amber,size:20 ,),
                  Text("(${widget.productIndex.rating?.count.toString()})")
                ],
              ),
              Text(widget.productIndex.description.toString()),
            ],
          ),
        ),

      ),
    );
  }
}
