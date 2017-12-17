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
    case bundleId = "bundleId"
    case teamId = "teamId"
    case keyId = "keyId"
    case keyPath = "keyPath"
    case deviceToken = "deviceToken"
}

final class App: Model {
    
    var storage = Storage()
    
    let title: String
    let bundleId: String
    let teamId: String
    let keyId: String
    let keyPath: String
    let deviceToken: String
    
    init(request: Request) throws {
        guard let title = request.data[AppProperty.title.rawValue]?.string,
              let bundleId = request.data[AppProperty.bundleId.rawValue]?.string,
              let teamId = request.data[AppProperty.teamId.rawValue]?.string,
              let keyId = request.data[AppProperty.keyId.rawValue]?.string,
              let keyPath = request.data[AppProperty.keyPath.rawValue]?.string,
              let deviceToken = request.data[AppProperty.deviceToken.rawValue]?.string else {
            throw Abort.badRequest
        }
        self.title = title
        self.bundleId = bundleId
        self.teamId = teamId
        self.keyId = keyId
        self.keyPath = keyPath
        self.deviceToken = deviceToken
    }
    
    required init(row: Row) throws {
        self.title = try row.get(AppProperty.title.rawValue)
        self.bundleId = try row.get(AppProperty.bundleId.rawValue)
        self.teamId = try row.get(AppProperty.teamId.rawValue)
        self.keyId = try row.get(AppProperty.keyId.rawValue)
        self.keyPath = try row.get(AppProperty.keyPath.rawValue)
        self.deviceToken = try row.get(AppProperty.deviceToken.rawValue)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        
        try row.set(AppProperty.title.rawValue, title)
        try row.set(AppProperty.bundleId.rawValue, bundleId)
        try row.set(AppProperty.teamId.rawValue, teamId)
        try row.set(AppProperty.keyId.rawValue, keyId)
        try row.set(AppProperty.keyPath.rawValue, keyPath)
        try row.set(AppProperty.deviceToken.rawValue, deviceToken)
        
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
            apps.string(AppProperty.bundleId.rawValue)
            apps.string(AppProperty.teamId.rawValue)
            apps.string(AppProperty.keyId.rawValue)
            apps.string(AppProperty.keyPath.rawValue)
            apps.string(AppProperty.deviceToken.rawValue)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}








