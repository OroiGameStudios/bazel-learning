def _build_with_custom_python_impl(ctx):
    
    out_file = ctx.actions.declare_file(ctx.attr.output_file_name)

    ctx.actions.run(
        outputs = [out_file],
        executable = ctx.executable._python_compiler,
        arguments = [ctx.file.python_file.path, out_file.path, ctx.attr.string_to_write_to_file],
    )

    return DefaultInfo(files=depset([out_file]))


build_with_custom_python = rule(
    implementation = _build_with_custom_python_impl,
    attrs = {
        "string_to_write_to_file": attr.string(),
        "python_file" : attr.label(allow_single_file = True),
        "output_file_name" : attr.string(),
        "_python_compiler": attr.label(
            executable = True,
            cfg = "exec",
            allow_files = True,
            default = "@downloaded-python//:python.exe",
        ),
        
    },
)
    