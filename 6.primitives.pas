program primitives;

// https://www.freepascal-meets-sdl.net/

uses 
    SDL2;

var
    i: Integer;
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    sdlRect1: TSDL_Rect;
    sdlPoints: array[0..499] of TSDL_Point;
    window_width: SInt32;
    window_height: SInt32;

begin

    window_width := 500;
    window_height := 500;


    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;


    sdlWindow1 := SDL_CreateWindow('Primitives Window', 50, 50, window_width, window_height, SDL_WINDOW_SHOWN);
    if sdlWindow1 = nil then Halt;

    sdlRenderer := SDL_CreateRenderer(sdlWindow1, -1, 0);
    if sdlRenderer = nil then Halt;

    // render and show cleared window with background color
    SDL_SetRenderDrawColor(sdlRenderer, 0, 255, 255, 255);
    SDL_RenderClear(sdlRenderer);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(1000);

    // render and show a line
    SDL_SetRenderDrawColor(sdlRenderer, 255, 0, 0, 255);
    SDL_RenderDrawLine(sdlRenderer, 10, 10, 490, 490);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(1000);

    // render and draw points diagonally with distance between each other
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, 255);
    for i := 0 to 47 do
        SDL_RenderDrawPoint(sdlRenderer, 490-i*10, 10+i*10);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(1000);

    // prepare, render, draw rectangle
    sdlRect1.x := 260;
    sdlRect1.y := 10;
    sdlRect1.w := 230;
    sdlRect1.h := 230;
    SDL_SetRenderDrawColor(sdlRenderer, 0, 255, 0, 255);
    SDL_RenderDrawRect(sdlRenderer, @sdlRect1);

    // relocate, render, draw the rectangle
    sdlRect1.x := 10;
    sdlRect1.y := 260;
    SDL_SetRenderDrawBlendMode(sdlRenderer, SDL_BLENDMODE_BLEND);
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 255, 128);
    SDL_RenderFillRect(sdlRenderer, @sdlRect1);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(1000);


    // prepare, render, draw 500 points with random x,y
    Randomize; // initializes the randomize procedure built into FreePascal
    for i := 0 to 499 do
        begin
            sdlPoints[i].x := Random(500);
            sdlPoints[i].y := Random(500);
        end;
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, 255);
    SDL_RenderDrawPoints(sdlRenderer, sdlPoints, 500);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(3000);

    // clean up
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);


    SDL_Quit;

end.
