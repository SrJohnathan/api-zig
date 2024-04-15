const zap = @import("zap");
const std = @import("std");
const server = @import("./server.zig");
const call = @import("./method_callback.zig");
const route = @import("./../route.zig");

pub const Routes = struct {
    var settings: call.Callback = undefined;
    path_name: ?[]const u8 = null,
    var ep: zap.Endpoint = undefined;


    
    pub fn init(rootPath: []const u8) *Routes {
        var res = Routes{};
        res.set_path(rootPath);
        return &res;
    }

    pub const Method = enum { GET, POST, PUT, DELETE };



    fn set_path(self: *Routes, rootPath: []const u8) void {
        self.path_name = rootPath;
    }

    pub fn mount(self: *Routes, method: Method, f: call.RequestFn) void {
       

        switch (method) {
            Method.GET => settings.g(f),
            Method.POST => settings.po(f),
            Method.PUT => settings.pu(f),
            Method.DELETE => settings.de(f),
        }

        settings = call.Callback{};

        ep = zap.Endpoint.init(.{ .path = self.path_name orelse "" , .get = settings.get_req(), .options = optionsUser });
    }

    pub fn run(self: *Routes) *zap.Endpoint {
        _ = self;

        return &ep;
    }
};

fn optionsUser(e: *zap.Endpoint, r: zap.Request) void {
    _ = e;
    r.setHeader("Access-Control-Allow-Origin", "*") catch return;
    r.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, PATCH, DELETE, OPTIONS") catch return;
    r.setStatus(zap.StatusCode.no_content);
    r.markAsFinished(true);
}
