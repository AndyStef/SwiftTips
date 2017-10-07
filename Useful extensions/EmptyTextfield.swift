extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}

guard let title = textField.text.nilIfEmpty else {
    // Alert: textField is empty!
    return
}
// title String is now unwrapped, non-empty, and ready for use
