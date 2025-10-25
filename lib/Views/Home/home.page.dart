import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Constants/global_variables.dart';
import 'package:sadd_asbl/Views/News/controller/news.provider.dart';
import 'package:video_player/video_player.dart';

import '../../Widgets/footer.widget.dart';
import '../../Widgets/whyus.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  VideoPlayerController? _playerCtrller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _playerCtrller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 120,
        ),
        Selector<NewsProvider, Map?>(
            selector: (_, provider) => provider.video,
            builder: (_, data, __) {
              // print(data);
              if (data?['contenu2'] != null &&
                  _playerCtrller == null &&
                  data!['contenu1'].toString().endsWith('.mp4')) {
                _playerCtrller = VideoPlayerController.networkUrl(
                  Uri.parse('${BaseUrl.apiUrl}/videos/${data['contenu2']}'),
                  videoPlayerOptions: VideoPlayerOptions(
                      allowBackgroundPlayback: false,
                      webOptions: const VideoPlayerWebOptions(
                          controls: VideoPlayerWebOptionsControls.enabled())),
                )..initialize().then((value) => setState(() async {
                      await _playerCtrller!.setVolume(0.2);
                      await _playerCtrller!.setLooping(true);
                      // videoUrl = widget.data.video!;
                      await _playerCtrller!.play();

                      // activeImage = '';
                    }));
              }

              if (data?['contenu2'] == null || _playerCtrller == null) {
                print(data);
                return Container();
              }
              return data?['contenu2'] == null || _playerCtrller == null
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: SizedBox(
                          // width: double.maxFinite,
                          // height: 300,
                          child: VideoPlayer(
                            _playerCtrller!,
                          ),
                        ),
                      ),
                    );
            }),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 0, top: 32, right: 0, bottom: 32),
          child: WhyUsComponentWidget(),
        ),
        const FooterComponentWidget(),
      ],
    );
  }
}
