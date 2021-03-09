program SDL_MouseCursor;

uses SDL2, SDL2_image;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlSurface1: PSDL_Surface;
  sdlMouseCursor: PSDL_Cursor;
  sdlEvent: TSDL_Event;
  ExitLoop: Boolean = False;

begin

  //initilization of video subsystem
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  SDL_CreateWindowAndRenderer(500, 500, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer);
  if (sdlWindow1 = nil) or (sdlRenderer = nil) then Halt;

  sdlSurface1 := IMG_Load('art/example_ball.png' );
  if sdlSurface1 = nil then Halt;

  // create and set new mouse cursor
  sdlMouseCursor := SDL_CreateColorCursor(sdlSurface1, 8, 8);
  if sdlMouseCursor = nil then Halt;

  SDL_SetCursor(sdlMouseCursor);

  while ExitLoop = False do
  begin

    // exit loop if mouse button pressed
    while SDL_PollEvent(@sdlEvent) = 1 do
      if sdlEvent.type_ = SDL_MOUSEBUTTONDOWN then
        ExitLoop := True;

    SDL_SetRenderDrawColor(sdlRenderer, 128, 128, 128, SDL_ALPHA_OPAQUE);
    SDL_RenderClear(sdlRenderer);

    SDL_RenderPresent(sdlRenderer);
    SDL_Delay( 20 );
  end;

  SDL_FreeCursor(sdlMouseCursor);

  SDL_FreeSurface(sdlSurface1);
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow (sdlWindow1);

  //shutting down video subsystem
  SDL_Quit;

end.
