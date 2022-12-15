# 1.5.2
* Eliminated Apple Watch base class; pod_2_watch is now a standalone UserAgent
* ATC > AirTrafficFramework is now a standalone user agent, and attempts to capture information about non-Apple Watch OSes

# 1.5.1
* Add support for Apple Podcasts agent ポッドキャスト.
* Updated Operating Systems mappings `Darwin` and `Android`

# 1.5.0
* Add browser support for Wondery Crawler

# 1.4.0
* Add browser support for Amazon Echo

# 1.3.0
* Add browser support for AndroidDownloadManager, AudioClip, BeyondPod, Breaker, Castro, Deezer, Downcast, Googlebot, Himalaya, iCatcher!, Luminary, NPR One, PodMN, Podcast Republic, Podimo, Podkicker, Podverse, RadioPublic, SoundOn, Spreaker

# 1.2.0
* Add browsers support for Audible, BlackBerry, Podbean, ThePodcastApp, TuneIn, Wondery, general Android
* Improve OkHttp

# 1.1.0

* Add `speaker?` and `desktop?`, and update existing browsers to support that
* Add browsers support with Acast, Airr, Alexa (Speaker & App), Amazon Music, Apple HomePod, Sonos, Castbox, iHeartRadio, Overcast, Spotify, Stitcher
* Improve Apple Podcasts, Pocket Casts, Podcast Addict
* Improve Pandora and support their RSS crawler
* Rename GoogleAssistant to GooglePodcasts and Improve it

# 1.0.1

* [#22](https://github.com/art19/useragent/pull/22) Add support for Edge on non-Windows OS (thanks @hollandmatt)

# 1.0.0

Due to inactivity on upstream we decided to treat this as a real, independent fork. The following changes are added to this version

* [#21](https://github.com/art19/useragent/pull/21) Improved support for watchOS
  * Replace former implementation of Apple Watch browers with new AirTraffic.framework and Pod2Watch
  * Add support for AirTraffic.framework on Apple Watch
  * Add support for Pod2Watch on Apple Watch
  * AppleCoreMedia now detects the Apple Watch operating system
  * Converted this gem to work as a real fork and bumped the version to 1.0.0
* [#20](https://github.com/art19/useragent/pull/20) Gecko android platform
* [#19](https://github.com/art19/useragent/pull/19) Add support for 'Edge Anaheim'
* [#18](https://github.com/art19/useragent/pull/18) Upgrade to Ruby 2.7
