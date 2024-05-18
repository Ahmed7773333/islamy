import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../assets.dart';
import '../providers/l_d_mode.dart';
import '../providers/radio.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color iconColor = Provider.of<ThemeProvider>(context).isDarkMode
        ? const Color(0xffFACC1D)
        : AppTheme.primaryColor;

    return ChangeNotifierProvider(
      create: (_) => RadioProvider()..fetchRadioStations(),
      child: Scaffold(
        body: Consumer<RadioProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.radioStations.isEmpty) {
              return Center(child: Text('No radio stations available'));
            }

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Provider.of<ThemeProvider>(context).isDarkMode
                        ? Assets().darkBackground
                        : Assets().ligtBackground,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (20 / 870),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.islamy,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (173 / 870),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (222 / 870),
                        width: MediaQuery.of(context).size.width * (412 / 412),
                        child: Image.asset(Assets().radios),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (57 / 870),
                      ),
                      Text(
                        AppLocalizations.of(context)!.quranRadio,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (57 / 870),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 3),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (_currentIndex > 0) {
                                  _currentIndex--;
                                  _audioPlayer.setSource(UrlSource(provider
                                      .radioStations[_currentIndex].url));
                                  _audioPlayer.play(UrlSource(provider
                                      .radioStations[_currentIndex].url));
                                }
                              });
                            },
                            icon: Icon(
                              Icons.skip_previous_rounded,
                              color: iconColor,
                              size: 40,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              if (_audioPlayer.state == PlayerState.playing) {
                                _audioPlayer.pause();
                              } else {
                                _audioPlayer.play(UrlSource(
                                    provider.radioStations[_currentIndex].url));
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              _audioPlayer.state != PlayerState.playing
                                  ? Icons.pause_circle_filled_rounded
                                  : Icons.play_arrow_rounded,
                              color: iconColor,
                              size: 40,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (_currentIndex <
                                    provider.radioStations.length - 1) {
                                  _currentIndex++;
                                  _audioPlayer.setSource(UrlSource(provider
                                      .radioStations[_currentIndex].url));
                                  _audioPlayer.play(UrlSource(provider
                                      .radioStations[_currentIndex].url));
                                }
                              });
                            },
                            icon: Icon(
                              Icons.skip_next_rounded,
                              color: iconColor,
                              size: 40,
                            ),
                          ),
                          const Spacer(flex: 3),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
