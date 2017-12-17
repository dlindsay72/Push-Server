import Vapor

extension Droplet {
    func setupRoutes() throws {
        
        get("apps") { _ in
            
            let apps = try App.all()
            
            return try apps.makeJSON()
        }
        
        post("insertApp") { request in
            let app = try App(request: request)
            try app.save()
            return try app.makeJSON()
        }
    }
}
