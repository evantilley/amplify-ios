// swiftlint:disable all
import Amplify
import Foundation

extension Todo {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case body
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let todo = Todo.keys
    
    model.pluralName = "Todos"
    
    model.fields(
      .id(),
      .field(todo.body, is: .required, ofType: .string)
    )
    }
}