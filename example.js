// How to access Buffers in Zig // //C++
const example = require('./dist/lib.node');

// buffer with size 10 bytes
// const buf1 = Buffer.alloc(10);

// buffer filled with 1's (10 bytes)
// const buf2 = Buffer.alloc(10, 1);

//buffer containing [0x1, 0x2, 0x3]
// const buf3 = Buffer.from([1, 2, 3]); 

// buffer containing ASCII bytes [0x74, 0x65, 0x73, 0x74].
const buf4 = Buffer.from('ABC');

// buffer containing bytes from a file
// const buf5 = fs.readFileSync("some file");

let buffer = buf4;

let result = example.rotate(buffer, buffer.length, 1);
// Result BCD with rotate = 1

console.log(buffer.toString('ascii'));
console.log(result.toString('ascii'));