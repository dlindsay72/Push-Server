//
//  App.swift
//  Push-ServerPackageDescription
//
//  Created by Dan Lindsay on 2017-12-15.
//

import Foundation
import Vapor
import FluentProvider

enum AppProperty: String {
    case title = "title"
}

final class App: Model {
    
    var storage = Storage()
    
    let title: String
    
    init(request: Request) throws {
        guard let title = request.data[AppProperty.title.rawValue]?.string else {
            throw Abort.badRequest
        }
        self.title = title
    }
    
    required init(row: Row) throws {
        self.title = try row.get(AppProperty.title.rawValue)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        
        try row.set(AppProperty.title.rawValue, title)
        
        return row
    }
    
}

extension App: JSONRepresentable {
    func makeJSON() throws -> JSON {
        let row = try makeRow()
        
        return try JSON(node: row.object)
    }
}

extension App: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (apps) in
            apps.id()
            apps.string(AppProperty.title.rawValue)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}








