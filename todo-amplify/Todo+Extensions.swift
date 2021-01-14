//
//  Todo+Extensions.swift
//  todo-amplify
//
//  Created by Evan Tilley on 1/13/21.
//

import Foundation

extension Todo: Identifiable {}

extension Todo: Hashable{
    public func hash(into hasher: inout Hasher){
        hasher.combine(id + body)
    }
}

extension Todo: Equatable {
    public static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id && lhs.body == rhs.body
    }
}
