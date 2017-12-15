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

class App {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
}
