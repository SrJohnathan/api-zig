const std = @import("std");
const zap = @import("zap");

const string = @import("./string.zig");
const server = @import("./server/server.zig");
const routes = @import("./server/routes.zig");

const route = @import("./route.zig");

pub fn main() !void {

    try back_end();
}

pub fn back_end() !void {


//  alocando memoria em uso geral

    var gpa = std.heap.GeneralPurposeAllocator(.{
        .thread_safe = true,
    }){};

    var allocator = gpa.allocator();


    // Criando rotas


    var rout = routes.Routes.init("/test");

    rout.mount(routes.Routes.Method.GET, route.get);


    // Crinado Http server


    const serve = server.Server.create(allocator);
    try serve.build();



  //  Cadastrando a rota
    try serve.add_endpoint(rout.run());



    // Start no servidor
    server.Server.start(2000, 1) catch return;

    const has_leaked = gpa.detectLeaks();
    std.log.debug("Has leaked: {}\n", .{has_leaked});
}

test "simple test" {
    // var list = std.ArrayList(i32).init(std.testing.allocator);
    // defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    // try list.append(42);
    //  try std.testing.expectEqual(@as(i32, 42), list.pop());
}
