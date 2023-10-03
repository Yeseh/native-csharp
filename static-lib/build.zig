const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig-cs",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target, 
        .optimize = optimize, 
    });

    b.installArtifact(exe);

    // Tell the linker to use our C# library
    exe.addLibraryPath("./bin/Release/net8.0/win-x64/publish");
    exe.addLibraryPath("C:/Users/JesseWellenberg/.nuget/packages/runtime.win-x64.microsoft.dotnet.ilcompiler/8.0.0-rc.1.23419.4/sdk");

    exe.linkSystemLibrary("Runtime.WorkstationGC");
    exe.linkSystemLibrary("eventpipe-disabled");
    exe.linkSystemLibrary("Runtime.VxsortEnabled");
    exe.linkSystemLibrary("System.Globalization.Native.Aot");
    exe.linkSystemLibrary("System.IO.Compression.Native.Aot");
    exe.linkSystemLibrary("NativeAOT_StaticInitialization");

    exe.linkSystemLibrary("static-lib");

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
