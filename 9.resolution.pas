program resolution;

// https://www.freepascal-meets-sdl.net/

uses 
    SDL2;

const
    Border:     TSDL_Rect = (x:   0; y:   0; w: 800; h: 450);
    Quarter:    TSDL_Rect = (x: 400; y: 225; w: 400; h: 225);

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;

begin

    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

    if SDL_CreateWindowAndRenderer(0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP, @sdlWindow1, @sdlRenderer) <> 0 then Halt;

    // set scaling filter
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, 'linear');

    // set logical resolution
    If SDL_RenderSetLogicalSize(sdlRenderer, 800, 450) <> 0 then Halt;

    // draw red border
    SDL_SetRenderDrawColor(sdlRenderer, 255, 0, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderDrawRect(sdlRenderer, @Border);

    // draw green quarter
    SDL_SetRenderDrawColor(sdlRenderer, 0, 255, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderDrawRect(sdlRenderer, @Quarter);

    // render 3 seconds
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(3000);

    // clean up
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);

    SDL_Quit;

end.
