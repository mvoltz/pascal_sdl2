program viewports;

// https://www.freepascal-meets-sdl.net/

uses 
    SDL2;

const
    Viewport1: TSDL_Rect = (x: 0;   y:   0; w: 400; h: 500);
    Viewport2: TSDL_Rect = (x: 400; y:   0; w: 100; h: 300);
    Viewport3: TSDL_Rect = (x: 400; y: 300; w: 100; h: 200);
    BlackDot : TSDL_Rect = (x: 10;  y:  10; w:   3; h:   3);

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;

begin

    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

    if SDL_CreateWindowAndRenderer(500, 500, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0 then Halt;

    // fill every viewport with background color and draw a black dot into it
    SDL_RenderSetViewport(sdlRenderer, @Viewport1);
    SDL_SetRenderDrawColor(sdlRenderer, 255, 0, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderFillRect(sdlRenderer, nil);
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderFillRect(sdlRenderer, @BlackDot);

    SDL_RenderSetViewport(sdlRenderer, @Viewport2);
    SDL_SetRenderDrawColor(sdlRenderer, 255, 255, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderFillRect(sdlRenderer, nil);
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderFillRect(sdlRenderer, @BlackDot);


    SDL_RenderSetViewport(sdlRenderer, @Viewport3);
    SDL_SetRenderDrawColor(sdlRenderer, 0, 255, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderFillRect(sdlRenderer, nil);
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, SDL_ALPHA_OPAQUE);
    SDL_RenderFillRect(sdlRenderer, @BlackDot);

    // render for 2 seconds
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(2000);

    // clean up
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);

    SDL_Quit;

end.
