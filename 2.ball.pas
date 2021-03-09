program ball_paddle;

// https://www.freepascal-meets-sdl.net

uses 
    SDL2;

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    sdlSurface1: PSDL_Surface;
    sdlTexture1: PSDL_Texture;
    window_width: SInt32;
    window_height: SInt32;

begin

    window_width := 800;
    window_height := 450;


    // init video subsystem
    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;



    // Create window and renderer
    if SDL_CreateWindowAndRenderer(window_width, window_height, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
        then Halt;



    // Create a surface from a file
    sdlSurface1 := SDL_LoadBMP('art/example_ball.bmp');
    if sdlSurface1 = nil then Halt;


    // Create a texture from the surface
    sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
    if sdlTexture1 = nil then Halt;


    // render the texture
    if SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil) <> 0 then Halt;


    // render for 2 seconds
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(2000);


    // clear memory 
    SDL_DestroyTexture(sdlTexture1);
    SDL_FreeSurface(sdlSurface1);
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);



    // close SDL2 and clean up fully
    SDL_Quit;

end.
