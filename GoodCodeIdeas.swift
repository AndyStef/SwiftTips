
//User input AlertController
func userInputAlert(_ title: String, isSecure: Bool = false, text: String? = nil, callback: @escaping (String) -> Void) {
  let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
  alert.addTextField(configurationHandler: { field in
      field.isSecureTextEntry = isSecure
      field.text = text
  })

  alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
     guard let text = alert.textFields?.first?.text, !text.isEmpty else {
        userInputAlert(title, callback: callback)
        return
    }

      callback(text)
  })

    let root = UIApplication.shared.keyWindow?.rootViewController
    root?.present(alert, animated: true, completion: nil)
}


// It's very good practise fot cells to have configure method that will configure every view in cell,
//so you won't need to use prepareForReuse

extension IndexPath {
  static func fromRow(_ row: Int) -> IndexPath {
    return IndexPath(row: row, section: 0)
  }
}

extension UITableView {
  func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
    beginUpdates()
    deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
    insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
    reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
    endUpdates()
  }
}
