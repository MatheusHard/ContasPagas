import 'package:flutter/material.dart';
import 'package:pagamento_de_contas/core/app_gradients.dart';
import 'package:pagamento_de_contas/core/app_text_styles.dart';

class AppBarWidget extends PreferredSize {
AppBarWidget():super(
  preferredSize: Size.fromHeight(200),

  child: Container(
      height: 150,
    decoration: BoxDecoration(
      gradient: AppGradients.linear
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Ola", style: AppTextStyles.title,),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(

                image: NetworkImage(
                  "https://avatars.githubusercontent.com/u/43302823?v=4"
                )
              )
            ),
          )
        ],
      ),
    ),
  ),
);

}
