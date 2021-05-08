

import 'package:flutter/material.dart';

class MenuItemConta {

   String _menuText;
   Icon _menuIcon;
   int _id;

  MenuItemConta(this._id, this._menuText, this._menuIcon);

  static List<MenuItemConta> menuItens = [
    new MenuItemConta(1, "Editar", Icon(Icons.update_rounded)),
    new MenuItemConta(2, "Excluir", Icon(Icons.delete_rounded))
  ];

   String get menuText => _menuText;
   Icon get menuIcon => _menuIcon;
   int get id => _id;
}


















