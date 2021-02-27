import 'package:flutter/material.dart';

int previousTapTime = 0;
int count = 0;
int totalTimeLapsed = 0;
int timeLapsed = 0;
double bpm = 0;

double tapTempo() {

  int idleTime = 3000;

  int currentTime = DateTime.now().millisecondsSinceEpoch;

  if (count != 0) {
    if(currentTime - previousTapTime > idleTime) {

      bpm = 0;
      count = 0;
      previousTapTime = 0;
      timeLapsed = 0;
      totalTimeLapsed = 0;

    } else {
      int timeLapsed = currentTime - previousTapTime;

      totalTimeLapsed += timeLapsed;

      double averageTimeLapsed = totalTimeLapsed / count;
      bpm = 1/(averageTimeLapsed/1000/60);
    }
  }

  previousTapTime = DateTime.now().millisecondsSinceEpoch;
  count ++;

  print(count);

  return bpm;
}


class MetronomePage extends StatefulWidget {
  @override
  _MetronomePageState createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '${bpm.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 90),
                  ),
                ),
              ),

            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Center(
                    child: RaisedButton(
                        onPressed: () {

                          setState(() {
                            bpm: tapTempo();
                          });
                          print('Button is tapped');
                        },
                        color: Colors.cyan[700],
                        child: Text('Tap', style: TextStyle(color: Colors.white))
                    )
                ),
              ),
              Expanded(
                child: Center(
                    child: RaisedButton(
                        onPressed: () {
                          bpm = 0;
                          setState(() {
                            bpm: bpm;
                          });
                          print('Butn $bpm is tapped');
                        },
                        color: Colors.cyan[700],
                        child: Text('Reset', style: TextStyle(color: Colors.white))
                    )
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Center(child: Text('Metronome')),
        ),
        body: MetronomePage()
      ),
    ),
  );
}
