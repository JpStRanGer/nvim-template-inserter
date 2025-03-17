
local M = {}

function M.get()
  return {
    "cmake_minimum_required(VERSION 3.10)",
    "project(MyProject)",
    "",
    "set(CMAKE_CXX_STANDARD 17)",
    "",
    "add_executable(MyExecutable main.cpp)",
  }
end

return M
