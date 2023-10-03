const std = @import("std");
// Add a declaration to our libraries 'Multiply' function
// Note that we use the name specified in the 'UnmangedCallersOnly' attribute
extern fn multiply(i32, i32) i32;

pub fn main() void {
    const result = multiply(2, 3);
    std.debug.print("Result: {}\n", .{result});
}