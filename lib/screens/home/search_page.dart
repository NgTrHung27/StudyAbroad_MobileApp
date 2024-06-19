import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/blocs/news_cubit_bloc/news_cubit.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/models/news.dart';
import 'package:kltn_mobile/screens/news/news_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<NewsList> newsList = [];
  final TextEditingController _searchController = TextEditingController();

  final List<NewsList> _data = [];
  List<NewsList> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
    context.read<NewsCubit>().getNewsList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _filteredData = _data.where((newsItem) {
        return newsItem.title
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NewsError) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is NewsLoaded) {
          Future.microtask(() {
            setState(() {
              _data.clear();
              _data.addAll(state.newsList);
              _performSearch();
            });
          });
          final isDarkMode = context.select((ThemeSettingCubit cubit) =>
              cubit.state.brightness == Brightness.dark);
          final textColor = isDarkMode ? Colors.white : Colors.black;
          final bgColor = isDarkMode ? Colors.black : Colors.white;
          return buildNewsList(textColor, bgColor);
        }
        return Container();
      },
    );
  }

  Widget buildNewsList(textColor, bgColor) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: textColor,
            onPressed: () => Navigator.pop(context),
          ),
          title: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.001),
              prefixIcon: const Icon(
                Icons.search,
                size: 20,
              ),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: _searchController.clear,
                      icon: const Icon(CupertinoIcons.clear_circled_solid)),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintText: 'Nhập thông tin...',
              hintStyle: const TextStyle(
                fontSize: 13,
              ),
              fillColor: bgColor,
              filled: true,
            ),
          ),
        ),
        body: _filteredData.isEmpty
            ? _isNotFound(textColor, bgColor)
            : _isFound(textColor, bgColor));
  }

  Widget _isNotFound(textColor, bgColor) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: TextMonserats("Không tìm thấy"),
      ),
    );
  }

  Widget _isFound(textColor, bgColor) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02),
            child: ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  NewsDetailPage(news: _filteredData[index])));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                                title: Text(_filteredData[index].title,
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      color: textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ))),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                height: 100,
                                _filteredData[index].cover.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                        ],
                      ),
                    )))));
  }
}
