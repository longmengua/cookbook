class HealthBankTypeHelper {
  static typeMessageConvert(String type) {
    var typeMessage;
    switch (type) {
      case 'M001':
        {
          typeMessage = "門診資料";
        }
        break;
      case 'M002':
        {
          typeMessage = "住診資料";
        }
        break;
      case 'M003':
        {
          typeMessage = "牙科健康存摺";
        }
        break;
      case 'M004':
        {
          typeMessage = "過敏資料";
        }
        break;
      case 'M005':
        {
          typeMessage = "檢驗(查)結果資料";
        }
        break;
      case 'M006':
        {
          typeMessage = "影像或病理檢驗" + "\n" + "(查)報告資料";
        }
        break;
      case 'M008':
        {
          typeMessage = "器捐或安寧緩和" + "\n" + "醫療意願";
        }
        break;
      case 'M009':
        {
          typeMessage = "預防接種存摺";
        }
        break;
      case 'M010':
        {
          typeMessage = "中醫健康存摺";
        }
        break;
      case 'M011':
        {
          typeMessage = "成人預防保健存摺";
        }
        break;
      case 'M012':
        {
          typeMessage = "癌症篩檢";
        }
        break;

      default:
        {
          typeMessage = 'no match';
        }
        break;
    }
    return typeMessage;
  }
}
