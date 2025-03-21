import 'package:flutter_dev_folio/src/custom/text_style.dart';
import 'package:flutter_dev_folio/src/htmlOpenLink.dart';
import 'package:flutter_dev_folio/src/projects/data.dart';
import 'package:flutter_dev_folio/src/theme/config.dart';
import 'package:flutter/material.dart';

class ProjectsCard extends StatelessWidget {
  const ProjectsCard(
      {Key? key,
      required this.height,
      required this.width,
      required this.title,
      required this.techStack,
      required this.desc,
      required this.link,
      required this.isMobile})
      : super(key: key);

  final double height, width;
  final String title, techStack, desc, link;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => htmlOpenLink(link),
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(
            top: height * 0.04,
            left: width * 0.015,
            right: width * 0.015,
            bottom: height * 0.04),
        width: !isMobile ? width * 0.28 : width,
        height: !isMobile ? height * 0.35 : height / 2,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(8, 12),
            )
          ],
          color: currentTheme.currentTheme == ThemeMode.dark
              ? Theme.of(context).cardColor
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
        child: (title == '' && link != '')
            ? FutureBuilder(
                future: github(link),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data as List<String>;
                    return Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  FittedBox(
                                      fit: BoxFit.cover,
                                      child: text(data[0], 25, Colors.white)),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, bottom: 16.0),
                                    child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: text(data[1], 14, Colors.white)),
                                  ),
                                  text(data[2], 15, Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/projects/constant/stars.png',
                                scale: 2),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: text(' ' + data[3], 12, Colors.white),
                            ),
                            Image.asset('assets/projects/constant/forks.png',
                                scale: 2),
                            text(' ' + data[4], 12, Colors.white),
                          ],
                        ),
                      ],
                    );
                  }
                  return Center();
                })
            : Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                                fit: BoxFit.cover,
                                child: text(title, 25, Colors.white)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 16.0),
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: text(techStack, 14, Colors.white)),
                            ),
                            text(desc, 15, Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: starsAndForks(link),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data as List<String>;
                          if (data[1] == "null" && data[0] == "null")
                            return Center();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/projects/constant/stars.png',
                                  scale: 2),
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: text(' ' + data[0], 12, Colors.white),
                              ),
                              Image.asset('assets/projects/constant/forks.png',
                                  scale: 2),
                              text(' ' + data[1], 12, Colors.white),
                            ],
                          );
                        }
                        return Center();
                      }),
                ],
              ),
      ),
    );
  }
}
