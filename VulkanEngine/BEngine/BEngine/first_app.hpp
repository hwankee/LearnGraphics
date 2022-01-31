#pragma once

#include "carrot_window.hpp"
#include "carrot_pipeline.hpp"
#include "carrot_device.hpp"
#include "carrot_swap_chain.hpp"

// std
#include <memory>
#include <vector>

namespace carrot {
    class FirstApp {
    public:
        static constexpr int WIDTH = 800;
        static constexpr int HEIGHT = 600;

        FirstApp();

        ~FirstApp();

        FirstApp(const FirstApp &) = delete;

        FirstApp &operator=(const FirstApp &) = delete;

        void run();

    private:
        void createPipelineLayout();

        void createPipeline();

        void createCommandBuffers();

        void drawFrame();

        CarrotWindow carrotWindow{WIDTH, HEIGHT, "Hello World!"};
        CarrotDevice carrotDevice{carrotWindow};
        CarrotSwapChain carrotSwapChain{carrotDevice, carrotWindow.getExtent()};
        std::unique_ptr<CarrotPipeline> carrotPipeline;
        VkPipelineLayout pipelineLayout;
        std::vector<VkCommandBuffer> commandBuffers;

//        CarrotPipeline carrotPipeline{
//                carrotDevice,
//                "/Users/BrightLand/Learn_MetalAPI/VulkanEngine/BEngine/BEngine/shaders/simple_shader.vert.spv",
//                "/Users/BrightLand/Learn_MetalAPI/VulkanEngine/BEngine/BEngine/shaders/simple_shader.frag.spv",
//                CarrotPipeline::defaultPipelineConfigInfo(WIDTH, HEIGHT)};
    };
}
