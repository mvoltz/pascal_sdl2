program fonts;

// https://www.freepascal-meets-sdl.net

uses 
    SDL2, SDL2_ttf;

var
    sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    sdlSurface1: PSDL_Surface;
    sdlTexture1: PSDL_Texture;
    ttfFont : PTTF_Font;
    sdlColor1, sdlColor2 : TSDL_Color;
    window_width: SInt32;
    window_height: SInt32;

begin

    window_width := 800;
    window_height := 450;


    if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;


    sdlWindow1 := SDL_CreateWindow('Font Window', 50, 50, window_width, window_height, SDL_WINDOW_SHOWN);
    if sdlWindow1 = nil then Halt;

    sdlRenderer := SDL_CreateRenderer(sdlWindow1, -1, 0);
    if sdlRenderer = nil then Halt;

    // initialize TrueType font engine and load a font
    if TTF_Init = -1 then Halt;
    ttfFont := TTF_OpenFont('fonts/TSCu_Comic.ttf', 40);
    TTF_SetFontStyle(ttfFont, TTF_STYLE_UNDERLINE or TTF_STYLE_ITALIC);
    TTF_SetFontOutline(ttfFont, 1);
    TTF_SetFontHinting(ttfFont, TTF_HINTING_NORMAL);


    // define colors by RGB values
    sdlColor1.r := 255; sdlColor1.g := 0; sdlColor1.b := 0;
    sdlColor2.r := 0; sdlColor2.g := 255; sdlColor2.b := 255;


    // create surface with Text
    sdlSurface1 := TTF_RenderText_Shaded(ttfFont, 'Hello World!', sdlColor1, sdlColor2);

    // convert surface to texture
    sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);

    // render texture

    SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(5000);


    // clean up
    TTF_CloseFont(ttfFont);
    TTF_Quit;

    SDL_DestroyTexture(sdlTexture1);
    SDL_FreeSurface(sdlSurface1);
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);


    SDL_Quit;

end.
