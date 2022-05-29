import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //TODO: link up images
  AssetImage cross=AssetImage('images/cross.png');
  AssetImage circle=AssetImage('images/circle.png');
  AssetImage edit=AssetImage('images/edit.png');


  //* state variablea
  bool isCross=true;
  String message='';
  List<String> gameState=List.filled(9, "empty");

  //TODO: Initialize the state of box with empty
  
  //TODO: play game method
  void playGame(int idx){
    if(gameState[idx]!="empty" || message.isNotEmpty)
    {
      return;
    }
  
    setState(() {
      if(isCross){
        gameState[idx]='cross';
      }
      else{
        gameState[idx]='circle';
      }
    });

    checkWin();
    isCross=!isCross;
  }

  //TODO: Reset game 
  void resetGame(){
    setState(() {
      isCross=true;
      message='';
      gameState=List.filled(9, "empty");
    });
  }

  //TODO: get image method
  AssetImage getImage(String val){
    if(val=='empty')
      return edit;
    else if(val=='cross')
      return cross;
    else if(val=='circle')
      return circle;
    return edit;
  }

  //TODO: check for win logic
  void checkWin(){
    String msg="";

    //? ROWS
    if(gameState[0]!="empty" && (gameState[0]==gameState[1]) && (gameState[1]==gameState[2]))
      msg='${gameState[0]} wins!';
    else if(gameState[3]!="empty" && (gameState[3]==gameState[4]) && (gameState[4]==gameState[5]))
      msg='${gameState[3]} wins!';
    else if(gameState[6]!="empty" && (gameState[6]==gameState[7]) && (gameState[7]==gameState[8]))
      msg='${gameState[6]} wins!';

    //? COLUMNS
    else if(gameState[0]!="empty" && (gameState[0]==gameState[3]) && (gameState[3]==gameState[6]))
      msg='${gameState[0]} wins!';
    else if(gameState[1]!="empty" && (gameState[1]==gameState[4]) && (gameState[4]==gameState[7]))
      msg='${gameState[1]} wins!';
    else if(gameState[2]!="empty" && (gameState[2]==gameState[5]) && (gameState[5]==gameState[8]))
      msg='${gameState[2]} wins!';

    //? DIAGONALS
    else if(gameState[0]!="empty" && (gameState[0]==gameState[4]) && (gameState[4]==gameState[8]))
      msg='${gameState[0]} wins!';
    else  if(gameState[2]!="empty" && (gameState[2]==gameState[4]) && (gameState[4]==gameState[6]))
      msg='${gameState[2]} wins!';

    //? DRAW
    else if(!gameState.contains("empty"))
      msg='Game Draw!';

    setState(() {
      message=msg;
    });

    //In case if we want auto reset after a few seconds..after win
    if(msg.isNotEmpty){
      Future.delayed(const Duration(seconds: 3),()=>resetGame());
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Tic Tac Toe"),
      ),
      body:Column(
        children: <Widget>[

          Expanded(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,  //? cross axis --> left to right, .. 3 items per row
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0
                  ),
                  itemCount: 9,
                  itemBuilder: (context,i) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 0.3,
                      ),
                    ),
                    height: 40, 
                    width: 40,
                    child: MaterialButton(
                      onPressed: (){playGame(i);},
                      child: Image(
                        image: getImage(gameState[i])
                      ),
                    ),
                  ) 
                ),

                Container(
                  margin:const EdgeInsets.only(top:30),
                  child: Text(message.toUpperCase(), style:const TextStyle(fontSize: 20, color:Colors.lightBlue, backgroundColor: Colors.amber, fontFamily: 'OpenSans', fontWeight: FontWeight.w900))
                ),

                Container(
                  margin:const EdgeInsets.only(top:20),
                  child: ElevatedButton(
                    onPressed: (){resetGame();},
                    child: const Text("Reset Game", style: TextStyle(fontSize: 20))
                  ),
                )

              ],
            ),
          ),

        ],
      ),

      
    );
  }
}