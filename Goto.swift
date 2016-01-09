struct Goto {
  typealias Closure = () -> Void
  var closures = [String: Closure]()
  mutating func set(label: String, closure: Closure) {
    closures[label] = closure
  }
  func call(label: String) {
    closures[label]?()
  }
}

infix operator • { associativity left precedence 140 }
func •(goto: Goto, label: String) {
  goto.call(label)
}
