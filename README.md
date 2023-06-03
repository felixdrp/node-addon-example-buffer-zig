# node-addon-example-buffer-zig <img alt="Zig Logo" src="https://raw.githubusercontent.com/ziglang/logo/master/zig-logo-dark.svg" width="200">

Example of addon using [Zig lang](https://ziglang.org/). How to access Buffers in Zig.<br>
For more info about `C/C++ addons with Node-API`, see [C/C++ addons with Node-API](https://nodejs.org/api/n-api.html) [[github]](https://github.com/nodejs/node/blob/main/doc/api/n-api.md).<br>

This example is based on:
 - [https://blog.risingstack.com/using-buffers-node-js-c-plus-plus/](https://blog.risingstack.com/using-buffers-node-js-c-plus-plus/)
 - [https://github.com/freezer333/nodecpp-demo/blob/master/buffers/basic/buffer_example.cpp](https://github.com/freezer333/nodecpp-demo/blob/master/buffers/basic/buffer_example.cpp)

### Other examples by @felixdrp
 - [https://github.com/felixdrp/node-addon-example-async-work-thread-safe-function-zig](https://github.com/felixdrp/node-addon-example-async-work-thread-safe-function-zig)
 - [node-addon-example-function-call-zig](https://github.com/felixdrp/node-addon-example-function-call-zig)

## Node.js Native Module written in Zig

This project is an example Hello World for making a Node.js native module in Zig. To install Zig:

- [https://ziglang.org/download/](https://ziglang.org/download/)
- [https://snapcraft.io/zig](https://snapcraft.io/zig)

The entry point is `src/lib.zig`.

Run this project like this:
```bash
# 1. Git clone it
git clone https://github.com/felixdrp/node-addon-example-buffer-zig.git

# 2. Download Node.js header files
npm run postinstall

# 3. Compile the Zig module and produce `dist/lib.node`
npm run build

# 4. Run example. It will call the `foo()` function from Zig module.
npm run exec

# Bonus: Debug mode (build dev) 🐛
npm run bdev
```

## License and acknowledgements

Many thanks to @staltz for his example.
[1]: https://staltz.com
[2]: https://github.com/staltz/zig-nodejs-example

Many thanks to `RisingStack Engineering`. [1]:(https://blog.risingstack.com)

## Learning Zig

 - [zig doc](https://ziglang.org/documentation/master/)
 - [zig api ref](https://ziglang.org/documentation/master/std/#A;std)
 - [ziglearn](https://ziglearn.org)
 - [ikrima.dev zig-crash-course](https://ikrima.dev/dev-notes/zig/zig-crash-course/)
 - [https://zig.news/](https://zig.news/)

## Debug Zig

- [Debug node addon by Atul](https://medium.com/@a7ul/debugging-nodejs-c-addons-using-vs-code-27e9940fc3ad)
- [Debug zig by Chris Watson](https://dev.to/watzon/debugging-zig-with-vs-code-44ca)
