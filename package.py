name = "materialx"

version = "1.36.4"

authors = [
    "Industrial Light & Magic"
]

description = \
    """
    MaterialX is an open standard for transfer of rich material and look-development content between applications
    and renderers.
    """

requires = [
    "cmake-3+",
    "gcc-6+",
    "osl-1.8+",
    "pybind11-2+",
    "python-2.7+<3"
]

variants = [
    ["platform-linux"]
]

tools = [
    ""
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "materialx-{version}".format(version=str(version))

def commands():
    env.LD_LIBRARY_PATH.prepend("{root}/lib")
    env.PYTHONPATH.prepend("{root}/python")
    env.CMAKE_MODULE_PATH.prepend("{root}/cmake/modules")

    # Helper environment variables.
    env.MATERIALX_INCLUDE_PATH.set("{root}/include")
    env.MATERIALX_LIBRARY_PATH.set("{root}/lib")
