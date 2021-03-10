import 'package:condosocio/src/components/lista_videos_alvo_tv.dart';
import 'package:condosocio/src/controllers/alvo_tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlvoTv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlvoTvController alvoTv = Get.put(AlvoTvController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Alvo Tv'),
      ),
      body: Obx(
        () {
          return alvoTv.isLoading.value
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
              : listaVideos(context);
        },
      ),
    );
  }
}
