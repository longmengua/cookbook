import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hi365/pages/healthknowledge/health_knowledge_screen_detail.dart';
import 'package:hi365/pages/iot/index.dart';
import 'health_knowledge_bloc.dart';
import 'health_knowledge_model.dart';
import 'health_knowledge_provider.dart';

class HealthKnowledgeScreen extends StatefulWidget {
  @override
  _HealthKnowledgeScreen createState() => _HealthKnowledgeScreen();
}

class _HealthKnowledgeScreen extends State<HealthKnowledgeScreen> {
  HealthKnowledgeBloc _healthKnowledgeBloc = HealthKnowledgeBloc();
  int _index = 0;
  Pageable _pageable = Pageable();
  HealthKnowledgeDB dataForSearch;
  String _keyword = '';

  @override
  void initState() {
    super.initState();
    _healthKnowledgeBloc.add(HealthKnowledgeEvent.latest);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.only(right: 15, left: 15, bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _searchBar(),
            SizedBox(
              height: 5,
            ),
            _switchBar(),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _board(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _board() {
    return StreamBuilder(
      stream: _healthKnowledgeBloc.stream,
      builder: (ctx, snapshot) {
        Widget toReturn;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            toReturn = loading(MediaQuery.of(context).size);
            break;
          case ConnectionState.done:
            if (snapshot.data == null || snapshot?.data?.code != 200) {
              toReturn = Center(
                child: Text(
                  '連線異常。',
                  style: TextStyle(fontSize: 20),
                ),
              );
              break;
            } else if (snapshot.data?.results == null ||
                snapshot.data.results.length <= 0) {
              toReturn = Center(
                child: Text(
                  '查詢結果，無資料可顯示。',
                  style: TextStyle(fontSize: 20),
                ),
              );
              break;
            }
            dataForSearch = snapshot.data;
            toReturn = Column(
              children: <Widget>[
                Expanded(
                  child: _index == 0
                      ? _latestArticle(dataForSearch)
                      : _popularArticle(dataForSearch),
                ),
//                _pageBar(_pageable),
              ],
            );
            break;
        }
        return toReturn;
      },
    );
  }

  Widget _searchBar() {
    Timer _timer;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: "Search",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _keyword = value;
                  if (_keyword == '') return;
                  if (_timer != null) _timer.cancel();
                  _timer = Timer(Duration(seconds: 2), () {
                    searchFuture(_keyword);
                  });
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (_timer != null) _timer.cancel();
              searchFuture(_keyword);
            },
          ),
        ],
      ),
    );
  }

  Widget _switchBar() {
    return Container(
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Center(
                child: Text(
                  '最新文章',
                  style: TextStyle(
                      color: _index == 0
                          ? Theme.of(context).accentColor
                          : Colors.black),
                ),
              ),
              onTap: () {
                _index = 0;
                _healthKnowledgeBloc.add(HealthKnowledgeEvent.latest);
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Center(
                child: Text(
                  '熱門文章',
                  style: TextStyle(
                      color: _index == 1
                          ? Theme.of(context).accentColor
                          : Colors.black),
                ),
              ),
              onTap: () {
                _index = 1;
                _healthKnowledgeBloc.add(HealthKnowledgeEvent.popular);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _latestArticle(HealthKnowledgeDB data) {
    List<Widget> body = [];
    body = createArticleWidget(_pageable.setData(data));
    print(_pageable);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: body,
        ),
      ),
    );
  }

  Widget _popularArticle(HealthKnowledgeDB data) {
    List<Widget> body = [];
    body = createArticleWidget(_pageable.setData(data));
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: body,
        ),
      ),
    );
  }

  List<Widget> createArticleWidget(List<ResultData> data) {
    return data.map((value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(HealthKnowledgeApiProvider.domainUrl + value?.fileUrl),
          Text(value.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          GestureDetector(
            child: Text(
              '詳細閱讀>>',
              style: TextStyle(color: Colors.green, fontSize: 20),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => HealthKnowledgeScreenDetail(value),
                ),
              );
            },
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: value.releaseTime?.substring(0, 10),
                children: <TextSpan>[
                  TextSpan(text: value.authorName),
                ]),
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      );
    }).toList();
  }

  Widget _pageBar(Pageable pageable) {
    List<Widget> widgets = [
      pageButton('<<'),
      pageButton('<'),
      pageButton((pageable.page)?.toString(), Theme.of(context).accentColor),
      pageButton('>'),
      pageButton('>>')
    ];
    if (pageable.page < pageable.totalPage)
      widgets.replaceRange(3, 3, [pageButton((pageable.page + 1)?.toString())]);
    if ((pageable.page - 1) > 0)
      widgets.replaceRange(2, 2, [pageButton((pageable.page - 1)?.toString())]);
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widgets,
      ),
    );
  }

  Widget pageButton(String flag, [Color color]) {
    return GestureDetector(
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            flag,
            style: TextStyle(color: color),
          ),
        ),
      ),
      onTap: () {
        if (flag == '<<') {
          _pageable.page = 1;
        } else if (flag == '<') {
          if (_pageable.page > 1) _pageable.page--;
        } else if (flag == '>') {
          if (_pageable.page < _pageable.totalPage) _pageable.page++;
        } else if (flag == '>>') {
          _pageable.page = _pageable.totalPage;
        } else {
          num no = num.tryParse(flag);
          if (no != null) _pageable.page = no;
        }
        setState(() {});
      },
    );
  }

  searchFuture(String keyword) {
    print(keyword);
    _healthKnowledgeBloc.keyword = keyword;
    _healthKnowledgeBloc.add(HealthKnowledgeEvent.search);
    setState(() {});
  }
}

class Pageable {
  int totalPage = 0;
  int page = 1;
  String sortBy;
  int countPerPage = 10;

  List<ResultData> setData(HealthKnowledgeDB data) {
    this.totalPage = data.results.length ~/ this.countPerPage + 1;
    num end = this.page * this.countPerPage;
    return data.results.sublist((this.page - 1) * this.countPerPage,
        end > data.results.length ? data.results.length : end);
  }
}
