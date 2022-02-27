#[macro_use]
extern crate glium;

// 그 어떤 물체라도 삼각형을 기반으로 만들 수 있다.
fn main() {
    #[allow(unused_importsm)]
    use glium::{glutin, Surface};

    let event_loop = glutin::event_loop::EventLoop::new();
    let wb = glutin::window::WindowBuilder::new();
    let cb = glutin::ContextBuilder::new();
    let display = glium::Display::new(wb, cb, &event_loop).unwrap();

    #[derive(Copy, Clone)]
    struct Vertex {
        position: [f32; 2],
    }

    implement_vertex!(Vertex, position);


    // 이 삼각형은 가운데 원점을 기준으로 생각하면 된다.
    let vertex1 = Vertex { position: [-0.5, -0.5] };
    let vertex2 = Vertex { position: [ 0.0,  0.5] };
    let vertex3 = Vertex { position: [ 0.5, -0.25] };
    let shape = vec![vertex1, vertex2, vertex3];

    // 비디오 카드의 기억장치에 위 모양을 업로드 하는 마지막 단계
    let vertex_buffer = glium::VertexBuffer::new(&display, &shape).unwrap();

    // Glium에 전달될 더미 마커
    let indices = glium::index::NoIndices(glium::index::PrimitiveType::TrianglesList);

    // shader
    // 앞의 버전은 OpenGL의 GLSL 셰이더 중 어떤 것을 사용할 것인가~ 에 대한 내용이다. (필수)

    // ++ 행렬!! -> 회전 및 스케일 값 조정하고 싶다면 매트릭스를 사용하면 좋다.
    // 순서는 매우 중요하다. matrix * ver4 로 한다.
    // ++ 색상 추가하기 out 변수
    let vertex_shader_src = r#"
        #version 140

        in vec2 position;
        out vec2 my_attr;   // our new attribute

        uniform mat4 matrix;

        void main() {
            my_attr = position;
            gl_Position = matrix * vec4(position, 0.0, 1.0);
        }
    "#;

    // 픽셀 셰이더
    // ++ 색상 추가를 위해 여기도 마찬가지로 in 변수를 추가한다.
    let fragment_shader_src = r#"
        #version 140

        in vec2 my_attr;
        out vec4 color;

        void main() {
            color = vec4(my_attr, 0.0, 1.0); // vec4 -> vec2
        }
    "#;

    let program = glium::Program::from_source(&display, vertex_shader_src, fragment_shader_src, None).unwrap();

    let mut t: f32 = -0.5;
    event_loop.run(move |ev, _, control_flow| {

        match ev {
            glutin::event::Event::WindowEvent { event, .. } => match event {
                glutin::event::WindowEvent::CloseRequested => {
                    *control_flow = glutin::event_loop::ControlFlow::Exit;
                    return;
                },
                _ => return,
            },
            _ => (),
        }

        let next_frame_time = std::time::Instant::now() +
            std::time::Duration::from_nanos(16_666_667);
        *control_flow = glutin::event_loop::ControlFlow::WaitUntil(next_frame_time);

        // we update `t`
        t += 0.0002;
        if t > 0.5 {
            t = -0.5;
        }

        let mut target = display.draw();
        target.clear_color(0.2, 0.2, 0.2, 1.0);
        // 삼각형은 여기서 그려줄 것이다!!
        // ++ 매트릭스 추가
        let uniforms = uniform! {
            matrix: [
                [t.cos(), t.sin(), 0.0, 0.0],
                [-t.sin(), t.cos(), 0.0, 0.0],
                [0.0, 0.0, 1.0, 0.0],
                [ t , 0.0, 0.0, 1.0f32],
            ]
        };

        target.draw(&vertex_buffer, &indices, &program, &uniforms,
                    &Default::default()).unwrap();

        target.finish().unwrap();
    });
}