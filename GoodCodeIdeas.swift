
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

// The way to handle all the changes in realm db (very handy and nice)
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    itemsToken = items?.observe { [weak tableView] changes in
      guard let tableView = tableView else { return }

      switch changes {
      case .initial:
        tableView.reloadData()
      case .update(_, let deletions, let insertions, let updates):
        tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
      case .error: break
      }
    }
  }

//
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    itemsToken?.invalidate()
  }



//Nice way for storing custom types in Realm
private let lat = RealmOptional<Double>()
private let lng = RealmOptional<Double>()
var lastLocation: CLLocation? {
  get {
    guard let lat = lat.value, let lng = lng.value else {
return nil
}
    return CLLocation(latitude: lat, longitude: lng)
  }
  set {
    guard let location = newValue?.coordinate else {
      lat.value = nil
      lng.value = nil
      return
}
    lat.value = location.latitude
    lng.value = location.longitude
  }
}


//Nice way for storing enum types in Realm
@objc dynamic private var _department =
  Department.technology.rawValue
var department: Department {
  get { return Department(rawValue: _department)! }
  set { _department = newValue.rawValue }
}
