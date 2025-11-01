@dynamicCallable
public struct Goto {
  public typealias Closure = () -> Void
  public private(set) var closures = [String: Closure]()

  public mutating func set(label: String, closure: Closure) {
    closures[label] = closure
  }

  public func call(label: String) {
    closures[label]?()
  }

  // MARK: - Dynamic Callable Support

  /// Enables dynamic calling syntax: goto.dynamicallyCall(withArguments: ["label"])
  @discardableResult
  public func dynamicallyCall(withArguments labels: [String]) -> Bool {
    guard let label = labels.first else { return false }
    closures[label]?()
    return closures[label] != nil
  }

  /// Enables keyword-based dynamic calling (if needed in the future)
  @discardableResult
  public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, String>) -> Bool {
    guard let (_, label) = args.first else { return false }
    closures[label]?()
    return closures[label] != nil
  }

  public init() {}
}

// MARK: - Operator Support

precedencegroup GotoPrecedence {
  associativity: left
  higherThan: AssignmentPrecedence
}

infix operator •: GotoPrecedence

public func •(goto: Goto, label: String) {
  goto.call(label)
}
