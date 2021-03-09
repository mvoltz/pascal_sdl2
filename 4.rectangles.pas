program rectangles;

// https://www.freepascal-meets-sdl.net

uses 
    SDL2, SDL2_image;

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    sdlSurface1: PSDL_Surface;
    sdlTexture1: PSDL_Texture;
    sdlRectangle: TSDL_Rect;
    window_width: SInt32;
    window_height: SInt32;

begin

    window_width := 800;
    window_height := 450;


    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;


    if SDL_CreateWindowAndRenderer(window_width, window_height, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0 then Halt;

    // set scaling quality
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, 'anistropic');

    // create surface from file
    sdlSurface1 := SDL_LoadBMP('art/example_ball.bmp');
    if sdlSurface1 = nil then Halt;

    // load image file
    sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
    if sdlTexture1 = nil then Halt;

    // describe rectangle
    sdlRectangle.x := 12;
    sdlRectangle.y := 25;
    sdlRectangle.w := 178;
    sdlRectangle.h := 116;


    SDL_RenderCopy(sdlRenderer, sdlTexture1, @sdlRectangle, nil);
    SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, @sdlRectangle);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(2000);


    SDL_DestroyTexture(sdlTexture1);
    SDL_FreeSurface(sdlSurface1);
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);


    SDL_Quit;

end.
