program window_render;

{ https://www.freepascal-meets-sdl.net/window-and-renderer/ }

uses 
    SDL2;

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    window_width: SInt32;
    window_height: SInt32;

begin

    window_width := 800;
    window_height := 450;


    // init video subsystem
    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;



    // describe the window we want to draw
    // args are: title, x, y, w, h, flags
    sdlWindow1 := SDL_CreateWindow('Window1', SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED, window_width, window_height, SDL_WINDOW_SHOWN);
    if sdlWindow1 = nil then Halt;


    {

     Draw to the screen from the described data structure above
     The -1 index chooses the first driver that supports the render
     SDL_RENDERER_ACCELERATED is the ideal choice of these options:
    
        1. SDL_RENDERER_SOFTWARE
        2. SDL_RENDERER_ACCELERATED
        3. SDL_RENDERER_PRESENTVSYNC
        4. SDL_RENDERER_TARGETTEXTURE

    }
    sdlRenderer := SDL_CreateRenderer(sdlWindow1, -1, 0);
    if sdlRenderer = nil then Halt;



    // render for 2 seconds
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(2000);



    // clear memory 
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);



    // close SDL2 and clean up fully
    SDL_Quit;

end.
