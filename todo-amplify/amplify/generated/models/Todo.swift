// swiftlint:disable all
import Amplify
import Foundation

public struct Todo: Model {
  public let id: String
  public var body: String
  
  public init(id: String = UUID().uuidString,
      body: String) {
      self.id = id
      self.body = body
  }
}