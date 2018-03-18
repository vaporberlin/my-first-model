import Routing
import Vapor
import Leaf

public func routes(_ router: Router) throws {

    router.get("users") { req -> Future<View> in
        let leaf = try req.make(LeafRenderer.self)

        let allUsers = User.query(on: req).all()

        return allUsers.flatMap(to: View.self) { users in
            let data = ["userlist": users]
            return leaf.render("userview", data)
        }
    }

    router.post("users") { req -> Future<Response> in
        let user = try req.content.decode(User.self)

        return user.map(to: Response.self) { user in
            _ = user.save(on: req)
            return req.redirect(to: "users")
        }
    }
}
