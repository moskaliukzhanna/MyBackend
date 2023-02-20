import Fluent
import Vapor

let controller = CommandConntroller()

func routes(_ app: Application) throws {
  
//    app.get { req async throws in
//        try await req.view.render("index", ["title": "Hello Vapor!"])
//    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("hello", ":name") { req -> String in
        guard let name = req.parameters.get("name") else {
            throw Abort(.internalServerError)
        }
//            return commands.first
        return name
    }
    
    controller.handleGETRequest(app: app)
    controller.handlePOSTRequest(app: app)

    try app.register(collection: TodoController())
}
