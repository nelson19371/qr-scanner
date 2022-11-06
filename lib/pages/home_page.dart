import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/direcciones_page.dart';
import 'package:qr_scanner/pages/mapas_page.dart';
import 'package:qr_scanner/widgets/custom_navigatorbar.dart';
import '../providers/ui_provider.dart';
import '../widgets/scan_button.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      

      body: _HomePageBody(),

      bottomNavigationBar: const CustomNavigationBar(),
       floatingActionButton: ScanButton(),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    //Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);


    //Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    switch(currentIndex){

      case 0:
        return MapasScreen();
      
      case 1:
         return DireccionesScreen();



      default:
        return MapasScreen();

    }


  }
}