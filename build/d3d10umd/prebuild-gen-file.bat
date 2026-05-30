set MESA_ROOT=%~dp0..\..\virtio-win-mesa\

:: virtio-win-mesa\src\util
set UTIL_DIR=%MESA_ROOT%src\util\
if not exist %UTIL_DIR%format_srgb.c (
    python %UTIL_DIR%format_srgb.py > %UTIL_DIR%format_srgb.c
    python %UTIL_DIR%driconf_static.py %UTIL_DIR%00-mesa-defaults.conf %UTIL_DIR%driconf_static.h
)

:: virtio-win-mesa\src\util\format
set FMT_DIR=%MESA_ROOT%src\util\format\
if not exist %FMT_DIR%u_format_gen.h (
    python %FMT_DIR%u_format_table.py %FMT_DIR%u_format.yaml --enums > %FMT_DIR%u_format_gen.h
    python %FMT_DIR%u_format_table.py %FMT_DIR%u_format.yaml --header > %FMT_DIR%u_format_pack.h
    python %FMT_DIR%u_format_table.py %FMT_DIR%u_format.yaml > %FMT_DIR%u_format_pack.c
)

:: virtio-win-mesa\src\compiler
set CMP_DIR=%MESA_ROOT%src\compiler\
if not exist %CMP_DIR%builtin_types.h (
    python %CMP_DIR%builtin_types_h.py %CMP_DIR%builtin_types.h
    python %CMP_DIR%builtin_types_c.py %CMP_DIR%builtin_types.c
)

:: virtio-win-mesa\src\compiler\nir
set NIR_DIR=%MESA_ROOT%src\compiler\nir\
if not exist %NIR_DIR%nir_opcodes.h (
    python %NIR_DIR%nir_opcodes_h.py > %NIR_DIR%nir_opcodes.h
    python %NIR_DIR%nir_opcodes_c.py > %NIR_DIR%nir_opcodes.c
    python %NIR_DIR%nir_builder_opcodes_h.py > %NIR_DIR%nir_builder_opcodes.h
    python %NIR_DIR%nir_constant_expressions.py > %NIR_DIR%nir_constant_expressions.c
    python %NIR_DIR%nir_intrinsics_h.py --out %NIR_DIR%nir_intrinsics.h
    python %NIR_DIR%nir_intrinsics_c.py --out %NIR_DIR%nir_intrinsics.c
    python %NIR_DIR%nir_intrinsics_indices_h.py --out %NIR_DIR%nir_intrinsics_indices.h
    python %NIR_DIR%nir_opt_algebraic.py --out %NIR_DIR%nir_opt_algebraic.c
)


:: virtio-win-mesa\src\gallium\auxiliary\util
set AUX_UTIL_DIR=%MESA_ROOT%src\gallium\auxiliary\util\
set PERF_DIR=%MESA_ROOT%\src\util\perf\
if not exist %AUX_UTIL_DIR%u_tracepoints.c (
    python %AUX_UTIL_DIR%u_tracepoints.py -p %PERF_DIR% -C %AUX_UTIL_DIR%u_tracepoints.c
    python %AUX_UTIL_DIR%u_tracepoints.py -p %PERF_DIR% -H %AUX_UTIL_DIR%u_tracepoints.h
)

:: virtio-win-mesa\src\gallium\auxiliary\driver_trace
set AUX_TR_DIR=%MESA_ROOT%src\gallium\auxiliary\driver_trace\
if not exist %AUX_TR_DIR%tr_util.c (
    python %AUX_TR_DIR%enums2names.py %AUX_TR_DIR%..\..\include\pipe\p_defines.h %AUX_TR_DIR%..\..\include\pipe\p_video_enums.h %AUX_TR_DIR%..\..\..\util\blend.h -C %AUX_TR_DIR%tr_util.c -H %AUX_TR_DIR%tr_util.h
)

:: virtio-win-mesa\src\gallium\auxiliary\indices
set AUX_IDX=%MESA_ROOT%src\gallium\auxiliary\indices\
if not exist %AUX_IDX%u_indices_gen.c (
    python %AUX_IDX%u_indices_gen.py %AUX_IDX%u_indices_gen.c
    python %AUX_IDX%u_unfilled_gen.py %AUX_IDX%u_unfilled_gen.c
)
