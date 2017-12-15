import Vapor

extension Droplet {
    func setupRoutes() throws {
        
        get("apps") { _ in
            
//            var json = JSON()
//            let app = App(title: "My First App")
//            try json.set("title", app.title)
            
            
            return "json"
        }
        
        post("insertApp") { request in
            let app = try App(request: request)
            
            return try app.makeJSON()
        }
    }
}
