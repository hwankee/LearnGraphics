#pragma once

#include "carrot_device.hpp"

// libs
#define GLM_FORCE_RADIANS
#define GLM_FORCE_DEPTH_ZERO_TO_ONE

#include <glm/glm.hpp>

// std
#include <vector>

namespace carrot {
    class CarrotModel {
    public:

        struct Vertex {
            glm::vec2 position;
            static std::vector<VkVertexInputBindingDescription> getBindingDescriptions();
            static std::vector<VkVertexInputAttributeDescription> getAttributeDescriptions();
        };

        CarrotModel(CarrotDevice &device, const std::vector<Vertex> &vertices);
        ~CarrotModel();

        CarrotModel(const CarrotModel &) = delete;
        CarrotModel &operator=(const CarrotModel &) = delete;

        void bind(VkCommandBuffer commandBuffer);
        void draw(VkCommandBuffer commandBuffer);

    private:
        void createVertexBuffers(const std::vector<Vertex> &vertices);

        CarrotDevice &carrotDevice;
        VkBuffer vertexBuffer;
        VkDeviceMemory vertexBufferMemory;
        uint32_t vertexCount;
    };
}