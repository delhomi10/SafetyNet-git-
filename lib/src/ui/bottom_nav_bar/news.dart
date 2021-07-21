import 'package:flutter/material.dart';
class News extends StatefulWidget {
  const News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(
          "Newsfeed"
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.menu),)
        ],
      ),
       body: Container(
         height: size.height,
         width: size.width,
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context,index){
            return Card(
              child: Container(height: size.height*0.28,
              width: size.width,
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Biden is new president Biden is new president Biden is new president Biden is new president Biden is new president Biden is new president",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        )),
                    Expanded(flex:1,child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          children: [
                            Icon(Icons.height),
                            Icon(Icons.height),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 10,),
                            Icon(Icons.favorite_border),
                            SizedBox(width: 10,),

                          ],
                        ),


                      ],
                    )),
                  ],
                ),
              ),
            );
          })

       ),
    );
  }
}
