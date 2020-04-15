import 'package:flutter/material.dart';
import 'package:hi365/pages/healthbank/healthbank_master_page.dart';
import 'package:hi365/pages/healthbank/health_bank_content.dart';
import 'package:hi365/utils/health_bank_type_helper.dart';
import 'package:logger/logger.dart';

class ListViewHealthBank extends StatefulWidget {
  final List<HealthBankMaster> masters;

  ListViewHealthBank({Key key, this.masters, this.title}) : super(key: key);

  final String title;

  @override
  _ListViewHealthBankState createState() => _ListViewHealthBankState();
}

class _ListViewHealthBankState extends State<ListViewHealthBank> {
  var logger = Logger(printer: PrettyPrinter());

  String getIconImagePath(String type) {
    String _imagePath = '';
    switch (type) {
      case 'M001':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m001_orange.png';
        break;
      case 'M002':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m002_orange.png';
        break;
      case 'M003':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m003_orange.png';
        break;
      case 'M004':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m004_orange.png';
        break;
      case 'M005':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m005_orange.png';
        break;
      case 'M006':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m006_orange.png';
        break;
      case 'M008':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m008_orange.png';
        break;
      case 'M009':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m009_orange.png';
        break;
      case 'M010':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m010_orange.png';
        break;
      case 'M011':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m011_orange.png';
        break;
      case 'M012':
        _imagePath = 'assets/images/healthbank/ic_bankbook_m012_orange.png';
        break;

      default:
        _imagePath = 'assets/images/healthbank/ic_bankbook_m001_orange.png';
        break;
    }
    return _imagePath;
  }

  Widget leadingPicker(String occurDate, String type) {
    String _imagePath = getIconImagePath(type);
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
                maxWidth: 30,
                maxHeight: 40,
              ),
              child: Image.asset(_imagePath, fit: BoxFit.cover)),
          new Text(
            occurDate ?? '',
            style: new TextStyle(
                color: Color.fromRGBO(17, 17, 17, 1), fontSize: 13.0),
          ),
        ],
      ),
    );
  }

  Widget outpatientCard(HealthBankMaster master, BuildContext context) {
    // 西醫門診 ,住診資料 ,中醫門診 ,牙科門診
    String typeName = HealthBankTypeHelper.typeMessageConvert(master.type);
    String hospitalName = master?.hospitalName ?? ' ';
    String diseaseCode = master?.diseaseCode ?? ' ';
    String diseaseName = master?.diseaseName ?? ' ';
    String occurDate = master?.dataTime1;
    String subtitle = hospitalName + '\n' + diseaseCode + diseaseName;

    return ListTile(
      leading: leadingPicker(occurDate, master.type),
      title: Text(
        typeName ?? '',
        style: TextStyle(
          fontSize: 18.0,
          color: Color.fromRGBO(17, 17, 17, 1),
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: TextStyle(
          fontSize: 13.0,
          color: Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
        ),
      ),
      trailing: Image.asset('assets/images/healthbank/ic_table_next_grey.png',
          fit: BoxFit.cover),
      onTap: () => _onTapItem(context, master),
    );
  }

  Widget examineCard(HealthBankMaster master, BuildContext context) {
    // M005:檢驗(查)結果資料, M006:影像或病理檢驗(查)報告資料 , M011:成人預防保健存摺 , M012:癌證篩檢
    String typeName = HealthBankTypeHelper.typeMessageConvert(master.type);
    String occurDate = master?.dataTime1 ?? '  ';
    String subtitle = ' ';
    if ('M012' != master.type) {
      subtitle = master?.hospitalName ?? '  ';
    } else {
      subtitle = master?.otherName ?? ' ';
    }
    if (master.type != 'M011') {
      return ListTile(
        leading: leadingPicker(occurDate, master.type),
        title: Text(
          typeName ?? '',
          style: TextStyle(
            fontSize: 18.0,
            color: Color.fromRGBO(17, 17, 17, 1),
          ),
        ),
        subtitle: Text(
          subtitle ?? '',
          style: TextStyle(
            fontSize: 13.0,
            color: Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
          ),
        ),
        trailing: Image.asset('assets/images/healthbank/ic_table_next_grey.png',
            fit: BoxFit.cover),
        onTap: () => _onTapItem(context, master),
      );
    } else {
      return ListTile(
        leading: leadingPicker(occurDate, master.type),
        title: Text(
          typeName ?? '',
          style: TextStyle(
            fontSize: 18.0,
            color: Color.fromRGBO(17, 17, 17, 1),
          ),
        ),
        subtitle: Text(
          subtitle ?? '',
          style: TextStyle(
            fontSize: 13.0,
            color: Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
          ),
        ),
        trailing: Image.asset('assets/images/healthbank/ic_table_next_grey.png',
            fit: BoxFit.cover),
      );
    }
  }

  Widget markCard(HealthBankMaster master, BuildContext context) {
    //註記類型
    String typeName = HealthBankTypeHelper.typeMessageConvert(master.type);
    String hospitalName = master?.hospitalName ?? '  ';
    String occurDate = master?.dataTime1 ?? '  ';
    String otherName = master?.otherName ?? '  ';
    String subtitle;
    if ('M004' == master.type) {
      // 過敏資料
      subtitle = hospitalName;
    } else if ('M008' == master.type) {
      // 器捐或安寧緩和醫療意願
      subtitle = '無醫療機構'; // ? need double check
    } else if ('M009' == master.type) {
      // 預防接種資料
      subtitle = hospitalName + ' \n ' + otherName;
    }

    return ListTile(
      leading: leadingPicker(occurDate, master.type),
      title: Text(
        typeName ?? '',
        style: TextStyle(
          fontSize: 18.0,
          color: Color.fromRGBO(17, 17, 17, 1),
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: TextStyle(
          fontSize: 14.0,
          color: Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
        ),
      ),
      trailing: Image.asset('assets/images/healthbank/ic_table_next_grey.png',
          fit: BoxFit.cover),
      onTap: () => _onTapItem(context, master),
    );
  }

  Widget _healthBankMasterCard(HealthBankMaster master, BuildContext context) {
    switch (master.type) {
      case 'M001':
        return outpatientCard(master, context);
        break;

      case 'M002':
        return outpatientCard(master, context);
        break;

      case 'M003':
        return outpatientCard(master, context);
        break;
      case 'M004':
        return markCard(master, context);
        break;
      case 'M005':
        // 檢驗(查)結果資料
        return examineCard(master, context);
        break;
      case 'M006':
        // 影像或病理檢驗(查)報告資料
        return examineCard(master, context);
        break;
      case 'M008':
        // 器捐或安寧緩和醫療意願
        return markCard(master, context);
        break;
      case 'M009':
        // 預防接種存摺
        return markCard(master, context);
        break;
      case 'M010':
        // 中醫健康存摺
        return outpatientCard(master, context);
        break;
      case 'M011':
        // 成人預防保健存摺
        return examineCard(master, context);
        break;
      case 'M012':
        // 癌症篩檢
        return examineCard(master, context);
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // https://stackoverflow.com/questions/49986303/flutter-can-i-add-a-header-row-to-a-listview
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
              ),
          itemCount: widget.masters == null ? 1 : widget.masters.length + 1,
          padding: const EdgeInsets.all(1.0),
          itemBuilder: (context, position) {
            if (position == 0) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      child: new Text(
                        '健康存摺',
                        style: new TextStyle(
                            color: Color.fromRGBO(17, 17, 17, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 34.0),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(74, 144, 226, 1),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: new Text(
                            '請點選',
                            style: new TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 14.0),
                          ),
                        ),
                        Container(
                            child: Image.asset(
                                'assets/images/healthbank/ic_toast_download.png',
                                fit: BoxFit.cover)),
                        Container(
                          padding: EdgeInsets.only(left: 5.0),
                          child: new Text(
                            '進行健康存摺的下載與上傳動作。',
                            style: new TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            position -= 1;
            return Column(
              children: <Widget>[
                Container(
                  child:
                      _healthBankMasterCard(widget.masters[position], context),
                  height: 100,
                  alignment: Alignment.center,
                ),
              ],
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, HealthBankMaster healthBankMaster) {
    var route = new MaterialPageRoute(
      builder: (BuildContext context) =>
          new HealthBankContent(master: healthBankMaster),
    );
    Navigator.of(context).push(route);
  }
}
