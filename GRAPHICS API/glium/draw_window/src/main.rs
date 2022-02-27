#[macro_use]
extern crate glium;
// 원래 OpenGL을 통해 윈도우를 띄우는 작업은 굉장히 어렵다. 하지만 여기선 glutin이 도와줄 것이다.

fn main() {
    use glium::{glutin, Surface};

    let event_loop = glutin::event_loop::EventLoop::new(); // 윈도우를 처리하고, 장치 이벤트를 처리한다.
    let wb = glutin::window::WindowBuilder::new(); // OpenGL과는 관계없는 윈도우 별 특성
    let cb = glutin::ContextBuilder::new(); // 다중 샘플링 및 vsync와 같은 OpenGL 특정 속성을 지정
    let display = glium::Display::new(wb, cb, &event_loop).unwrap(); // 디스플레이가 구축됨, event_properties에 윈도우를 등록한다.

    // 창을 닫을 때까지 반복할 필요가 있다.
    event_loop.run(move |ev, _, control_flow| {

        // OpenGL은 이중 버퍼링을 한다.
        // 여기서는 색상을 지정해본다.
        let mut target = display.draw();
        target.clear_color(0.0, 1.0, 1.0, 1.0);
        target.finish().unwrap();

        let next_frame_time = std::time::Instant::now() +
            std::time::Duration::from_nanos(16_666_667);

        *control_flow = glutin::event_loop::ControlFlow::WaitUntil(next_frame_time);
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
    });
}