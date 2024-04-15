const zap = @import("zap");
const std = @import("std");

pub const RequestFn = *const fn (self: *zap.Endpoint, r: zap.Request) void;

pub const Callback = struct {
    const Self = @This();

    var get: RequestFn = undefined;
    var post: RequestFn = undefined;
    var put: RequestFn = undefined;
    var delete: RequestFn = undefined;

    pub fn get_req(self: *Callback) RequestFn {
          _ = self;
        return get;
    }


     pub fn post_req(self: *Callback) RequestFn {
          _ = self;
        return post;
    }

     pub fn put_req(self: *Callback) RequestFn {
          _ = self;
        return put;
    }


     pub fn delete_req(self: *Callback) RequestFn {
          _ = self;
        return delete;
    }

   

    pub fn g(self: *Callback, s: RequestFn) void {
        _ = self;
        get = s;
    }

    pub fn po(self: *Callback, s: RequestFn) void {
        _ = self;
        post = s;
    }

    pub fn pu(self: *Callback, s: RequestFn) void {
        _ = self;
        put = s;
    }

    pub fn de(self: *Callback, s: RequestFn) void {
        _ = self;
        delete = s;
    }
};
