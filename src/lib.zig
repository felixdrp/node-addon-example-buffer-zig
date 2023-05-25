// Example based on https://blog.risingstack.com/using-buffers-node-js-c-plus-plus/
// https://github.com/freezer333/nodecpp-demo/blob/master/buffers/basic/buffer_example.cpp
const c = @cImport({
    @cInclude("node_api.h");
});

const std = @import("std");
// Allocator 
// https://ziglearn.org/chapter-2/
// https://ziglang.org/documentation/master/#Choosing-an-Allocator
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

fn nativeFunction(env: c.napi_env, info: c.napi_callback_info) callconv(.C) c.napi_value {
    // Generic vars
    var global: c.napi_value = undefined;
    var status: c.napi_status = c.napi_get_global(env, &global);
    var result: c.napi_value = undefined;

    // Get Buffer from function parameters
    var argc: usize  = 3; // equivalent type size_t More info https://ziglang.org/documentation/master/#Primitive-Types
    var argv: [3]c.napi_value = .{};
    // [out] thisArg: Receives the JavaScript this argument for the call. thisArg can optionally be ignored by passing NULL.
    // [out] data: Receives the data pointer for the callback. data can optionally be ignored by passing NULL.
    var thisArg: c.napi_value = undefined;
    // var data: *anyopaque = undefined;

    // https://nodejs.org/api/n-api.html#napi_get_cb_info
    status = c.napi_get_cb_info(env, info, &argc, &argv, &thisArg, null);

    var value_type: c.napi_valuetype = undefined;
    status = c.napi_typeof(env, argv[0], &value_type);

    var size: u32 = 0;
    var rot_32: u32 = 0;
    // Get buffer size
    status = c.napi_get_value_uint32(env, argv[1], &size);
    // Get rotation amount
    status = c.napi_get_value_uint32(env, argv[2], &rot_32);
    var rot: u8 = @intCast(u8, rot_32);

    var buffer_size: usize = @as(usize, size);
    var buffer_pointer: ?*anyopaque = undefined;

    // Get memory
    // https://ziglang.org/documentation/master/#Memory
    // https://github.com/ziglang/zig/issues/3952
    var retval_buf = std.heap.raw_c_allocator.alloc(u8, buffer_size) catch |err| { // <-- capture err here
        std.debug.print("Oops! {}\n", .{err});
        return result;
    };

    // Convert pointer type Slice to array
    var retval: [*c]u8 = @ptrCast([*c]u8, retval_buf.ptr);

    // Get buffer pointer
    status = c.napi_get_buffer_info(env,
                                    argv[0],
                                    &buffer_pointer,
                                    &buffer_size
    );
    
    // Change pointer type from ?*anyopaque (void *) to pointer C to u8 array
    var buffer: [*c]u8 = @intToPtr([*c]u8, @ptrToInt(buffer_pointer));

    var i: u32 = 0;
    while (i < size) : ( i+=1 ) {
        retval[i] = buffer[i] - rot;
        buffer[i] += rot;
    }

// Why napi_create_external_buffer:
// https://github.com/nodejs/node/blob/main/src/node_api.cc#L1011
// https://github.com/nodejs/nan/blob/main/doc/buffers.md#api_nan_new_buffer
    status = c.napi_create_external_buffer(env, buffer_size,
        @intToPtr(?*anyopaque, @ptrToInt(retval_buf.ptr)),
        null,
        null,
        &result
    );

    return result;
}

export fn napi_register_module_v1(env: c.napi_env, exports: c.napi_value) c.napi_value {
    var function: c.napi_value = undefined;
    if (c.napi_create_function(env, null, 0, nativeFunction, null, &function) != c.napi_ok) {
        _ = c.napi_throw_error(env, null, "Failed to create function");
        return null;
    }

    if (c.napi_set_named_property(env, exports, "rotate", function) != c.napi_ok) {
        _ = c.napi_throw_error(env, null, "Failed to add function to exports");
	    return null;
    }

    return exports;
}
