import Vapor

extension Droplet {
  func setupRoutes() throws {
    
    get("user") { req in
      let list = try User.all()
      return try self.view.make("userview", ["userlist": list.makeNode(in: nil)])
    }
    
    post("user") { req in
      guard let username = req.data["username"]?.string else {
        return Response(status: .badRequest)
      }
      let user = User(username: username)
      try user.save()
      return Response(redirect: "/user")
    }
  }
}
