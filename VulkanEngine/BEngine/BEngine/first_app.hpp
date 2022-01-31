#pragma once

#include "lve_window.hpp"
#include "lve_pipeline.hpp"

namespace lve {
    class FirstApp {
    public:
        static constexpr int WIDTH = 800;
        static constexpr int HEIGHT = 600;

        void run();

    private:
        LveWindow lveWindow{WIDTH, HEIGHT, "Hello World!"};
        LvePipeline lvePipeline{"/Users/BrightLand/Learn_MetalAPI/VulkanEngine/BEngine/BEngine/shaders/simple_shader.vert.spv", "/Users/BrightLand/Learn_MetalAPI/VulkanEngine/BEngine/BEngine/shaders/simple_shader.frag.spv"};
    };
}