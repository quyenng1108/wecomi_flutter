import 'package:flutter/material.dart';
import 'package:wecomi_flutter/components/until.dart';
import 'package:wecomi_flutter/constants/utils.dart';
import 'package:wecomi_flutter/models/read_history.dart';

class ReadHistoryProvider extends ChangeNotifier {
  List<ReadHistory> readHistoryList = [];
  bool isLoading = true;

  showProgress() {
    if (isLoading) {
      return;
    }
    isLoading = true;
    notifyListeners();
  }

  dismissProgress() {
    if (!isLoading) {
      return;
    }
    isLoading = false;
    notifyListeners();
  }

  void deleteHistory(List<int> indexList) {
    var box = Utils.getReadHistory();
    for (int i = 0; i < indexList.length; i++) {
      readHistoryList.removeAt(readHistoryList.length - 1 - indexList[i] + i);
      box.deleteAt(box.length - 1 - indexList[i] + i);
    }
    notifyListeners();
  }

  void saveReadHistory(ReadHistory readHistory) {
    var box = Utils.getReadHistory();
    bool hasReadHistoryExisted = false;
    int index = 0;
    if (readHistoryList.isNotEmpty) {
      for (int i = 0; i < readHistoryList.length; i++) {
        if (readHistory.bookId == readHistoryList[i].bookId) {
          hasReadHistoryExisted = true;
          index = i;
          break;
        }
      }
      if (hasReadHistoryExisted) {
        readHistoryList.removeAt(index);
        readHistoryList.add(readHistory);
        box.deleteAt(index);
        box.add(readHistory);
      } else {
        readHistoryList.add(readHistory);
        box.add(readHistory);
      }
    } else {
      readHistoryList.add(readHistory);
      box.add(readHistory);
    }
    notifyListeners();
  }

  void loadHistory() {
    showProgress();
    var box = Utils.getReadHistory();
    readHistoryList = box.values.cast<ReadHistory>().toList();
    notifyListeners();
    dismissProgress();
  }
}
