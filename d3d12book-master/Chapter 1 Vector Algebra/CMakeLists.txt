cmake_minimum_required(VERSION 3.21)
project(Chapter_1_Vector_Algebra)

set(CMAKE_CXX_STANDARD 14)

add_executable(Chapter_1_Vector_Algebra
        XMVECTOR/InitFunctions.cpp
        XMVECTOR/tol.cpp
        XMVECTOR/VectorOps.cpp
        XMVECTOR/xmvec3.cpp)
