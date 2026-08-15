



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Pet Care') ,
    ),
    body: 
      Center(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center ,
          mainAxisAlignment: MainAxisAlignment.center,
          children :[ 
            SizedBox(height: 20),
            Text('Hello',style: AppStyle.title),
           SizedBox(height: 20),
            Text('pety pety ',style: AppStyle.subtitle),
        
          
          ]
        ),
      ),
    );
  
    
    
  }
}