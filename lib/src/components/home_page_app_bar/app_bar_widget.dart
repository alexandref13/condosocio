import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AppBarWidget extends PreferredSize {
  final BuildContext context;
  final VoidCallback onTap;
  final String image;
  AppBarWidget({
    this.context,
    this.onTap,
    this.image = '',
  }) : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
            height: 100,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 161,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          FontAwesome.bars,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        onPressed: onTap,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://www.condosocio.com.br/acond/downloads/logocondo/$image',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 26,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}
