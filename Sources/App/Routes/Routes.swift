import Vapor

extension Droplet {
    func setupRoutes() throws {
        
        get("apps") { _ in
            
            var json = JSON()
            let app = App(title: "My First App")
            try json.set("title", app.title)
            
            
            return json
        }
        
        post("insertApp") { request in
            guard let myParameter = request.data["myParameter"]?.string else {
                print("Missing parameter")
                throw Abort.badRequest
            }
            return myParameter
        }
    }
}
