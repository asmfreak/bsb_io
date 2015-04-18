from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = [
    Extension(
        "bsb_io",
        sources=["bsb_io.pyx", "bsb_fastio.c"],
        libraries=["m"]
    )
]

setup(
    name="bsb_io",
    cmdclass={'build_ext': build_ext},
    ext_modules=ext_modules
)
