import Vapor

func routes(_ app: Application) throws {
    app.get { refq in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    app.get("hello", ":name") { req -> String in
        guard let name = req.parameters.get("name") else {
            throw Abort(.internalServerError)
        }

        return "Hello, \(name)!"
    }

    app.get("hello", "vapor") { req -> String in
        return "Hello Vapor!"
    }

    app.post("info") { (req) -> InfoData in
        let data = try req.content.decode(InfoData.self)
//        return "Hello \(data.name)!"
//        return InfoResponse(request: data)
        return data
    }
    
    app.post("infotest") { (req) -> InfoResponse in
        let data = try req.content.decode(InfoData.self)
//        return "Hello \(data.name)!"
        return InfoResponse(request: data)
    }
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let request: InfoData
}
