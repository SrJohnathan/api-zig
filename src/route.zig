const zap = @import("zap");
const std = @import("std");

pub fn get(endpoint: *zap.Endpoint, request: zap.Request) void {
    if (request.path) |path| {

        std.debug.print("get  {any}  \n", .{ path });

    }

   

    _ = endpoint;
    request.sendBody("<html><body><h1>Servidor Teste Github</h1></body></html>") catch return;
}
