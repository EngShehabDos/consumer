import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:consumer/fontSize.dart';
import 'package:consumer/rate.dart';
import 'getFaces.dart';

void main() {
  runApp(ConsumerMy());
}
class ConsumerMy extends StatelessWidget {
  const ConsumerMy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(),
    );
  }
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (BuildContext context)=> RateNotifire(),
      ),
      ChangeNotifierProvider(
      create: (BuildContext context)=> fontSizeNotifier(),
      )
    ],
      child: MainScreen(),
    );

  }
}



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var fontSizeprovider=Provider.of<fontSizeNotifier>(context,listen: false);
    var rateprovider=Provider.of<RateNotifire>(context,listen: false);
    print('the bulid tree has been rebulid');
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black87,
          body: Column(
            // mainAxisAlignment:MainAxisAlignment.center ,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
          Consumer<fontSizeNotifier>(builder: (context, fontSize, widget){
            print('Consumer 1');
        return Text('Rate us',
        style: TextStyle(
        fontSize: fontSize.fontsize,
        color: Colors.white)
          ,);
        }),

              SizedBox(
                height: 33,
              ),
    Consumer<RateNotifire>(builder: (context, rateConsumer, widget){
      print('consumer 2');
             return getFaces(rateConsumer.rate.toInt());}),
              Expanded(child: Container()),
              Text('Chang the text size' , style: TextStyle(fontSize: 14, color: Colors.white)),

              Consumer<fontSizeNotifier>(builder: (context, fontSizeConsumer, widget){
                print ('consumer 3');
                return Slider(
                  value: fontSizeConsumer.fontsize,
                  onChanged: (newValue){
                    fontSizeConsumer.changeFontSize(newValue);
                  },
                  max:50,
                  min: 20,
                );
              }),

              Text('rate them',style: TextStyle(fontSize: 14, color: Colors.white)),

              Consumer<RateNotifire>(builder: (context, rateConsumer, widget){
              print('consumer 4');
                return Slider(
                  value: rateConsumer.rate,
                  onChanged: (newValue){
                    rateConsumer.changeRating(newValue);
                  },
                  max:4,
                  min: 0,
                );}),

              SizedBox(
                height: 44,
              )
            ],
          ),
        ));
  }
}



