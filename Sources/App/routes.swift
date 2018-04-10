import Routing
import Vapor
import Leaf

public func routes(_ router: Router) throws {

    router.get("users") { req -> Future<View> in
        let allUsers = User.query(on: req).all()

        return allUsers.flatMap(to: View.self) { users in
            let data = ["userlist": users]
            return try req.view().render("userview", data)
        }
    }

    router.post("users") { req -> Future<Response> in
        let user = try req.content.decode(User.self)

        return user.save(on: req).map(to: Response.self) { _ in
            return req.redirect(to: "users")
        }
    }
}
