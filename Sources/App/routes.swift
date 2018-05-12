import Vapor
import Leaf

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // view with users
    router.get("users") { req -> Future<View> in
        return User.query(on: req).all().flatMap { users in
            let data = ["userlist": users]
            return try req.view().render("userview", data)
        }
    }

    // create a new user
    router.post("users") { req -> Future<Response> in
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req).map { _ in
                return req.redirect(to: "users")
            }
        }
    }
}
