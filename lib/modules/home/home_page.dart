import 'package:flutter/material.dart';
import 'package:split_it/modules/home/home_controller.dart';
import 'package:split_it/modules/home/home_state.dart';
import 'package:split_it/modules/home/widgets/app_bar/app_bar_widget.dart';
import 'package:split_it/modules/home/widgets/event_tile_widget.dart';
import 'package:split_it/modules/login/models/user_model.dart';
import 'package:split_it/shared/models/event_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController();

  @override
  void initState() {
    controller.getEvents();
    controller.listen((state) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBarWidget(
        user: user,
        onTap: () {
          Navigator.pushNamed(context, "/create_split");
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (controller.state is HomeStateLoading) ...[
                ...List.generate(
                    2,
                    (index) => EventTileWidget(
                          model: EventModel(),
                          isLoading: true,
                        ))
              ] else if (controller.state is HomeStateSuccess) ...[
                ...(controller.state as HomeStateSuccess)
                    .events
                    .map(
                      (EventModel model) => EventTileWidget(
                        model: model,
                      ),
                    )
                    .toList(),
              ] else if (controller.state is HomeStateFailure) ...[
                Center(
                    child:
                        Text((controller.state as HomeStateFailure).message)),
              ] else ...[
                Container()
              ]
            ],
          ),
        ),
      ),
    );
  }
}
