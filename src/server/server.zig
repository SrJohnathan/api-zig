const std = @import("std");
const zap = @import("zap");

fn req(re: zap.Request) void {
       if (re.path) |the_path| {
        std.debug.print("REQUESTED PATH: {s}\n", .{the_path});
    }
        re.sendBody("<html><body><h1>CERTO</h1></body></html>")  catch return;

   
}

pub const Server = struct {
    const Self = @This();

    var _zap: zap.Endpoint.Listener = undefined;
    var port: i32 = 3000;
    var fn_request: ?(fn (zap.Request) void) = undefined;
    var allocator: std.mem.Allocator = undefined;

    pub fn create(alloc: std.mem.Allocator) *Server {
        allocator = alloc;
        var s = Server{};

        return &s;
    }

    

    pub fn build(self: *Self) !void {
        _ = self;

        _zap = zap.Endpoint.Listener.init(allocator, .{
            .port = @intCast(port),
            .max_clients = 100000,
            .on_request = req,
            .log = true,
            .public_folder = "./../public",
            .max_body_size = 100 * 1024 * 1024,
        });

  
   defer _zap.deinit();
     
    }


    pub fn add_endpoint(self: *Self, end: *zap.Endpoint) !void {
        _ = self;
       try _zap.register(end) ;
   
    }


    pub fn start(num_threads: i32, num_workers: i32) !void {
        try _zap.listen();
        std.debug.print("Listening on 0.0.0.0:{}\n", .{port});
        zap.start(.{ .threads = @intCast(num_threads), .workers = @intCast(num_workers) });
    }
};
