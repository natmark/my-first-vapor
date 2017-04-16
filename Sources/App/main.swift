import Vapor
import HTTP

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("person") { request in
    guard let name = request.data["name"]?.string,
          let city = request.data["city"]?.string else{
        throw Abort.badRequest
    }
    print(name,city)
    return try Response(status: .created, json: JSON(node: [
        "name": name,
        "city": city
    ]))
}

drop.get("json") { request in
  let json = try JSON(node: [
    "name": "Atsuya Sato",
    "nickName": "natmark",
    "age": 20
  ])
  return json
}

drop.get("hello") { request in
    let name = request.data["name"]?.string ?? "stranger"
    return try drop.view.make("hello",[
        "name":name
    ])
}

drop.resource("posts", PostController())

drop.run()
