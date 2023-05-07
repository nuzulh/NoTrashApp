import 'package:flutter/material.dart';
import 'package:no_trash/models/information.dart';
import 'package:no_trash/providers/common.dart';
import 'package:no_trash/widgets/information_card.dart';
import 'package:no_trash/widgets/inline_text.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/screen_label.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          ScreenLabel(icon: Icons.widgets_rounded, label: 'Informasi'),
          InlineText(label: 'Pengetahuan', value: ''),
          FutureBuilder<List<InformationModel>>(
            future: Common().getArticles(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<InformationModel> knowledges = snapshot.data!
                    .where((x) => x.category == 'knowledge')
                    .toList();

                return Container(
                  height: 280,
                  padding: const EdgeInsets.only(bottom: 14, top: 6),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: knowledges.length,
                    itemBuilder: (context, index) => InformationCard(
                      information: knowledges[index],
                    ),
                  ),
                );
              } else {
                return const Loading();
              }
            },
          ),
          InlineText(label: 'Berita', value: ''),
          FutureBuilder<List<InformationModel>>(
            future: Common().getArticles(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<InformationModel> knowledges =
                    snapshot.data!.where((x) => x.category == 'news').toList();

                return Container(
                  height: 280,
                  padding: const EdgeInsets.only(bottom: 14, top: 6),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: knowledges.length,
                    itemBuilder: (context, index) => InformationCard(
                      information: knowledges[index],
                    ),
                  ),
                );
              } else {
                return const Loading();
              }
            },
          ),
        ],
      ),
    );
  }
}
