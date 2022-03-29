import 'package:flutter/material.dart';
import 'package:split_it/modules/home/widgets/add_button_widget.dart';
import 'package:split_it/modules/home/widgets/card_widget.dart';
import 'package:split_it/modules/login/models/user_model.dart';
import 'package:split_it/theme/app_theme.dart';

class AppBarWidget extends PreferredSize {
  final UserModel user;
  AppBarWidget({Key? key, required this.user})
      : super(
          key: key,
          child: Stack(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: AppTheme.gradients.background,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(user.photoUrl!)),
                    title: RichText(
                      text: TextSpan(
                        text: 'Olá, ',
                        style: AppTheme.textStyles.greeting,
                        children: <TextSpan>[
                          TextSpan(
                              text: user.name!,
                              style: AppTheme.textStyles.titleAppbar),
                        ],
                      ),
                    ),
                    trailing: AddButtonWidget(
                      onTap: () {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    CardWidget(
                      receive: true,
                      value: 497,
                    ),
                    CardWidget(
                      receive: false,
                      value: 161,
                    ),
                  ],
                ),
              ),
            ],
          ),
          preferredSize: const Size.fromHeight(250),
        );
}
