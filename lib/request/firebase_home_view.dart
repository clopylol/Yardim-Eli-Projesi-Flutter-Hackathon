import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local ToDo",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local ToDo"),
      ),
      body: MainHome(),
    );
  }
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  //Text Field'dan bu veriyi değişkene alalım.
  TextEditingController toDoTxt = TextEditingController();
  //Listeyi Oluşturalım
  List toDoList = [];

  //Listeye Eleman Eklemek İçin Kullc. Fonk
  addToDo() {
    setState(() {
      toDoList.add(toDoTxt.text);
      toDoTxt.clear();
    });
  }

  //Listeden Eleman Silmek İçin Kullc. Fonk.
  removeToDo() {
    setState(() {
      toDoList.remove(toDoTxt.text);
      toDoTxt.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: [
            //ListView kullansaydık uyg. çalıştığı zaman tüm liste yüklenecekti. Performansı düşürür.
            //ListView.Builder kullanarak sadece ekranda gözüken kısmın yüklenmesini sağlayacağız. Kaydırdıkça yükler. Performans arttırır.
            Flexible(
              child: ListView.builder(
                //Listenin uzunluğu
                itemCount: toDoList.length,
                itemBuilder: (context, index) => ListTile(
                  subtitle: Text("To Do App"),
                  tileColor: Colors.lightBlue,
                  title: Text(
                    toDoList[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: toDoTxt,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: "Exp: Homework",
                suffixIcon: Icon(Icons.addchart),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: addToDo,
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: removeToDo,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
