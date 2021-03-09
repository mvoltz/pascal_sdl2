program keyboard_states;

// https://www.freepascal-meets-sdl.net/

uses 
    SDL2;

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    sdlRectangle: TSDL_Rect;
    sdlKeyboardState: PUInt8;
    Running: Boolean = True;

begin

    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

    if SDL_CreateWindowAndRenderer(500, 500, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0 then Halt;

    // prepare, render, draw rectangle
    sdlRectangle.x := 250;
    sdlRectangle.y := 250;
    sdlRectangle.w := 10;
    sdlRectangle.h := 10;

    // program loop
    while Running = True do
        begin
            SDL_PumpEvents;
            sdlKeyboardState := SDL_GetKeyboardState(nil);

            // ESC pressed
            if sdlKeyboardState[SDL_SCANCODE_ESCAPE] = 1 then
                Running := False;

            // WASD keys pressed
            if sdlKeyboardState[SDL_SCANCODE_W] = 1 then
                sdlRectangle.y := sdlRectangle.y-1;
            if sdlKeyboardState[SDL_SCANCODE_A] = 1 then
                sdlRectangle.x := sdlRectangle.x-1;
            if sdlKeyboardState[SDL_SCANCODE_S] = 1 then
                sdlRectangle.y := sdlRectangle.y+1;
            if sdlKeyboardState[SDL_SCANCODE_D] = 1 then
                sdlRectangle.x := sdlRectangle.x+1;

            // black background
            SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, SDL_ALPHA_OPAQUE);
            SDL_RenderClear(sdlRenderer);
            // draw red rectangle
            SDL_SetRenderDrawColor(sdlRenderer, 255, 0, 0, SDL_ALPHA_OPAQUE);
            SDL_RenderDrawRect(sdlRenderer, @sdlRectangle);

            SDL_RenderPresent(sdlRenderer);
            SDL_Delay(20);
        end;


    // clean up
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);

    SDL_Quit;

end.
