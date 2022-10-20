import 'package:benh_nhan_noi_tru_his/utilities/globals.dart';
import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import '../../commons.dart';

class HomeHeaderScreen extends StatefulWidget {
  const HomeHeaderScreen({Key? key}) : super(key: key);

  @override
  State<HomeHeaderScreen> createState() => _HomeHeaderScreenState();
}

class _HomeHeaderScreenState extends State<HomeHeaderScreen>
    with TickerProviderStateMixin {
  int messageUnread = 5;

  @override
  Widget build(BuildContext context) {
    bool isOrientationPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: SizedBox(
            height: isOrientationPortrait
                ? Commons.headerSize
                : Commons.headerSize / 2,
            child: AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(options: particles),
              child: GestureDetector(
                onTap: (() {
                  if (messageUnread > 0) {
                    setState(() {
                      messageUnread -= 1;
                    });
                  }
                }),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, isOrientationPortrait ? 90 : 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chào \r\n${Commons.userLogin!.fullName!.toUpperCase()}",
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Icon(
                            messageUnread > 0
                                ? Icons.notifications_active_sharp
                                : Icons.notifications,
                            color: Commons.k3Color,
                          ),
                          Text(
                            messageUnread > 0
                                ? " Bạn có $messageUnread tin nhắn chưa xem"
                                : " Bạn không có tin nhắn nào !",
                            style: const TextStyle(
                              fontSize: Commons.fontSize16,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Hero(
            tag: Commons.heroAccount,
            child: CircleAvatar(
              radius: 70,
              backgroundImage:
                  AssetImage(Globals.avatarRandom(setToUserLogin: true)),
            ),
          ),
        ),
      ],
    );
  }

  // hiệu ứng background
  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.blueAccent,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 50,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 15.0,
    spawnMinSpeed: 10,
    spawnMinRadius: 7.0,
  );
}
