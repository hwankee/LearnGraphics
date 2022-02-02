# BaseCode   
***     
>- General structure   
>- Resource managerment   
>- Integrating GLFW   
    
원본: [Vulkan Tutotial Page](https://vulkan-tutorial.com/Drawing_a_triangle/Setup/Base_code "vulkan link")   
### 실행 화면   
![run](../Img/basecode0.png "baseCode")     
***   
# General Structure    
> Vulkan 의 일반 구조   
```cpp   
#include <vulkan/vulkan.h>

#include <iostream>
#include <stdexcept>
#include <cstdlib>

class HelloTriangleApplication {
public:
    void run() {
        initVulkan();
        mainLoop();
        cleanup();
    }

private:
    void initVulkan() {

    }

    void mainLoop() {

    }

    void cleanup() {

    }
};

int main() {
    HelloTriangleApplication app;

    try {
        app.run();
    } catch (const std::exception& e) {
        std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
```
# Resource Management
> 자원 관리

`malloc`-`free`는 우리가 할당한 모든 vulkan 오브젝트들은 우리가 더 이상 필요로 하지 않을 때, 확실하게 파괴할 수 있다.    
c++에서는 자동 자원 관리를 [RAII](https://en.wikipedia.org/wiki/Resource_acquisition_is_initialization "raii") 를 
통해서 하거나 `<memory>`헤더에 있는 스마트 포인터를 사용하여 할 수 있다.          
하지만 이 튜토리얼에서는 확실하게 파괴시키는 방식(malloc-free)을 선택하기로 했다.         
어쨌든 위 방식은 실수를 피할 수 있고, 오브젝트의 생명 주기를 배우고, API가 어떻게 동작하는지 학습하기에 더 나을 것이다.     

이 튜토리얼을 수행한 후 우리는 Vulkan 오브젝트를 생성하는 생성자와 파괴자 부분에 해당 내용을 작성하여 자동 리소스 관리를 구현할 수 있다.       
아니면 필요에 따라 `std::unique_ptr` 또는 `std::shared_ptr`를 사용할 수도 있다.       
RAII는 거대한 Vulkan 프로그램을 돌릴 때 추천되는데, 배우는 단계에서는 Scene이 어떻게 동작하는 지를 아는 것이 더 중요하다.           

Vulkan 오브젝트는 `vKCreateXXX`와 같은 함수로 호출되거나, `vKAllocateXXX`와 같은 함수를 통해 다른 오브젝트를 할당할 수도 있다.        
만든 오브젝트가 더 이상 필요하지 않을 때는 각각 생성 함수에 맞게 `vKDestroyXXX`나 `vKFreeXXX`를 사용하여 삭제하면 된다.    
두 함수는 각기 다른 변수타입의 파라미터를 갖는데, 하나의 파라미터 즉, `pAllocator`는 두 함수 모두 포함된다. 이것은 선택적인 파라미터인데,
커스텀 메모리의 할당의 명시적인 콜백을 할 수 있게 한다. 우리는 이 튜토리얼에서 해당 파라미터를 무시하고, `nullPtr`을 사용할 것이다.     




# Integrating GLFW
> GLFW 통합 (window(실행창)를 통한 실습환경 구축)   

사실 윈도우 창이 없어도, 정상 작동을 한다.   
하지만 실제로 보면서 하는 편이 더 낫기 때문에 실습 환경을 구축하는 것이다.   
그러므로 아래 내용을 따르자.   
먼저 `#include <vulkan/vulkan.h>`를 아래 내용으로 바꾸어 주자.   
```c++
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
```
***
Vulkan을 자동 적재하고, 자체 정의 또한 포함하는 GLFW를 사용할 수 있게 되었다.     
이제 `initWindow`를 헤더 부분에 넣고 (지금은 private 부분), `run`의 가장 위에 두어서   
가장 먼저 호출될 수 있도록 하자.   
```c++
void run() {
    initWindow();
    initVulkan();
    mainLoop();
    cleanup();
}

private:
    void initWindow() {
    
    }
```
***
`initWindow` 내에서 가장 먼저 호출될 것은 `glfwInit()`로, GLFW 라이브러리를 초기화하는 일을 한다.   
하지만 본래 GLFW는 openGL용으로 디자인되었기 때문에, 우리는 openGL로 생성되지 않게 아래 함수를 사용해야 한다.       
```c++
glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
```
***
사이즈가 조절된 window는 취급시 특별 주의가 필요하기 때문에 우리는 이 부분을 다음에 보기로 하고,   
지금은 다른 Window 호출을 통해 비활성화 시켜주자.   
```c++
glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);
```
***
이제 남은 것은 실제 창을 만드는 일 뿐이다. GLFWwindow* window;를 private class 멤버로 만들어 두자.   
그리고 window를 초기화하는 방법은 이렇다.   
```c++
// 처음 세 개의 매개 변수는 창의 너비, 높이 그리고 제목을 뜻한다.
// 네번째 매개 변수를 사용하면 모니터를 선택적으로 창을 열 수 있는 모니터를 허락한다.
// 마지막 파라미터는 openGL에만 해당된다.. (궁금해)
window = glfwCreateWindow(800, 600, "Vulkan", nullptr, nullptr);
```
***

이제 우리의 initWindow` 함수는 이렇게 생겼을 것이다.   
```c++
void initWindow() {
    glfwInit();

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    window = glfwCreateWindow(WIDTH, HEIGHT, "Vulkan", nullptr, nullptr);
}
```
***

우리는 mainLoop 함수를 통해 프로그램을 error가 발생하거나, window를 닫지 않는 이상 계속 돌릴 수 있다.   
```c++
void mainLoop() {
    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
    }
}
```
***
이 코드는 중요하다. 프로그램을 닫는 이벤트(예를 들면 x버튼을 유저가 누른다던가)를 반복하고 확인한다.   
또한 단일 프레임을 렌더링할 때(Late call)도 반복한다.   
window가 닫히면, 우리는 자원을 정리하고 GLFW를 자체 종료시켜야 한다.   
이것이 우리의 첫번째 `cleanup` 코드이다.
```c++
void cleanup() {
    glfwDestroyWindow(window);

    glfwTerminate();
}
```
***

이제 프로그램을 실행시켜보자! `Vulkan`이라는 제목(만약 다른 걸로 바꿨다면 그거)의 프로그램이 실행될 것이다!      
우리가 닫기 전까지는 계속 켜져 있는 것을 볼 수 있을 것이다.      
우리는 이제 Vulkan의 뼈대를 만들 것이다..!  
[Vulkan 오브젝트 만들러 가기](../Draw a triangle/02_Instance.md "instance")
