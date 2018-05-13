
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


//Save way to build NSPredicate
extension Person {
  static let fieldHairCount = "hairCount"
  static let fieldDeceased = "deceased"
  static func allAliveLikelyBalding(
    `in` realm: Realm, hairThreshold: Int = 1000) -> Results<Person> {
    let predicate = NSPredicate(format: "%K < %d AND %K = nil",
      Person.fieldHairCount, hairThreshold, Person.fieldDeceased)
    return realm.objects(Person.self).filter(predicate)
  }
}

//Complex Realm query with subquery
let articlesAboutFrank = realm.objects(Article.self).filter("""
    title != nil AND
    people.@count > 0 AND
    SUBQUERY(people, $person,
      $person.firstName BEGINSWITH %@ AND
      $person.born > %@).@count > 0
    """, "Frank", Date.distantPast)
                                                            
                                                            
//DateFormatter                                                           
extension DateFormatter {
  static var mediumTimeFormatter: DateFormatter {
    let f = DateFormatter()
    f.dateStyle = .none
    f.timeStyle = .medium
    return f
  }
}
                                                            
//Random array element                                                           
private func random(min: UInt32, max: UInt32) -> Int {
  return Int(arc4random_uniform(max) + min)
}

extension Array {
  func randomElement() -> Element {
    return self[random(min: 0, max: UInt32(count-1))]
  }
}

                                                            
//Different urls to store realm files
                                                            
let documentsUrl = try! FileManager.default
    .url(for: .documentDirectory, in: .userDomainMask,
      appropriateFor: nil, create: false)
    .appendingPathComponent("myRealm.realm")
                                                            
let libraryUrl = try! FileManager.default
    .url(for: .libraryDirectory, in: .userDomainMask,
      appropriateFor: nil, create: false)
    .appendingPathComponent("myRealm.realm")
                                                            
let bundledURL = Bundle.main
  .url(forResource: "bundledRealm", withExtension: "realm")
                                                            
let sharedURL = FileManager.default
  .containerURL(forSecurityApplicationGroupIdentifier:
    "group.com.razeware.app")!
  .appendingPathComponent("Library/shared.realm")
                                                            
                                                            
                                                            
                                                            
extension ToDoItem {

  static func all(in realm: Realm = try! Realm()) -> Results<ToDoItem> {
    return realm.objects(ToDoItem.self)
      .sorted(byKeyPath: ToDoItem.Property.isCompleted.rawValue)
  }

  @discardableResult
  static func add(text: String, in realm: Realm = try! Realm()) -> ToDoItem {
    let item = ToDoItem(text)
    try! realm.write {
      realm.add(item)
    }
    return item
  }

  func toggleCompleted() {
    guard let realm = realm else { return }
    try! realm.write {
      isCompleted = !isCompleted
    }
  }

  func delete() {
    guard let realm = realm else { return }
    try! realm.write {
      realm.delete(self)
    }
  }
}
                                                            
                                                            

enum PathError: Error, LocalizedError {
  case notFound

  var errorDescription: String? {
    switch self {
      case .notFound: return "Resource not found"
    }
  }
}

class Path {
  static func inLibary(_ name: String) throws -> URL {
    return try FileManager.default
      .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      .appendingPathComponent(name)
  }

  static func inDocuments(_ name: String) throws -> URL {
    return try FileManager.default
      .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      .appendingPathComponent(name)
  }

  static func inBundle(_ name: String) throws -> URL {
    guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
      throw PathError.notFound
    }
    return url
  }

  static func documents() throws -> URL {
    return try FileManager.default
      .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
  }
}
                                                            
                                                            
                                                            
                                                            
extension String {

  /// Uses CommonCrypto framework to generate sha512 of the current string
  var sha512: Data? {
    let stringData = data(using: String.Encoding.utf8)!
    var result = Data(count: Int(CC_SHA512_DIGEST_LENGTH))
    _ = result.withUnsafeMutableBytes { resultBytes in
      stringData.withUnsafeBytes { stringBytes in
        CC_SHA512(stringBytes, CC_LONG(stringData.count), resultBytes)
      }
    }

    return result
  }
}

