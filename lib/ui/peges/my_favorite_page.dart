part of 'pages.dart';

class MyFavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Favorite',
          style: fontTitle.copyWith(fontSize: 20),
        ),
      ),
      body: Container(
        child: BlocBuilder<VideosCubit, VideosState>(builder: (_, videosState) {
          if (videosState is VideosLoaded) {
            bool isFavorite = false;
            List<Videos> videos = videosState.listVideos
                    .where((element) => element.isFavorite == true)
                    .toList() ??
                [];
            return (videos.length > 0)
                ? ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            Get.to(DetailVideoPage(videos[index]));
                          },
                          child: Container(
                            height: Get.height / 3,
                            margin: EdgeInsets.symmetric(
                                vertical: 2.5, horizontal: defaultMargin),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: Get.height / 3 - 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              videos[index].thumnails),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  videos[index].title,
                                                  style: blackTextFont.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            BlocBuilder<UserCubit, UserState>(
                                              builder: (_, userState) =>
                                                  (!isFavorite)
                                                      ? IconButton(
                                                          icon: Icon(
                                                              Icons.favorite,
                                                              color: (videos[
                                                                          index]
                                                                      .isFavorite)
                                                                  ? Colors.red
                                                                  : accentColor2),
                                                          onPressed: () {
                                                            if (!videos[index]
                                                                .isFavorite) {
                                                              Favorite favorite = Favorite(
                                                                  idUser: (userState
                                                                          as UserLoaded)
                                                                      .user
                                                                      .idUser
                                                                      .toString(),
                                                                  idVideo: videos[
                                                                          index]
                                                                      .id);
                                                              context
                                                                  .read<
                                                                      VideosCubit>()
                                                                  .addFavorite(
                                                                      favorite);
                                                            } else {
                                                              context
                                                                  .read<
                                                                      VideosCubit>()
                                                                  .removeFavorite(
                                                                      videos[index]
                                                                          .id,
                                                                      (userState
                                                                              as UserLoaded)
                                                                          .user
                                                                          .idUser
                                                                          .toString());
                                                            }
                                                          })
                                                      : loading(1),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                          "Publish : " +
                                              videos[index]
                                                  .publisheAt
                                                  .dateAndTimeNumber,
                                          style: blackTextFont),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                : Center(child: Text('You do not have a favorite video'));
          } else {
            return Center(
              child: loading(4.0),
            );
          }
        }),
      ),
    );
  }
}
