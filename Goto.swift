public struct Goto {
  public typealias Closure = () -> Void
  internal var closures = [String: Closure]()
  public mutating func set(label: String, closure: Closure) {
    closures[label] = closure
  }
  public func call(label: String) {
    closures[label]?()
  }
}

infix operator • { associativity left precedence 140 }
public func •(goto: Goto, label: String) {
  goto.call(label)
}
