program ball_using_SDL_image;

// https://www.freepascal-meets-sdl.net

uses 
    SDL2, SDL2_image;

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    sdlTexture1: PSDL_Texture;
    window_width: SInt32;
    window_height: SInt32;

begin

    window_width := 800;
    window_height := 450;


    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;


    sdlWindow1 := SDL_CreateWindow('Window1', SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED, window_width, window_height, SDL_WINDOW_SHOWN);

    sdlRenderer := SDL_CreateRenderer(sdlWindow1, -1, 0);
    if sdlRenderer = nil then Halt;

    // this is where we use SDL_image

    sdlTexture1 := IMG_LoadTexture( sdlRenderer, 'art/example_ball.png' );
    if sdlTexture1 = nil then Halt;


    SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(2000);


    SDL_DestroyTexture(sdlTexture1);
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);


    SDL_Quit;

end.
