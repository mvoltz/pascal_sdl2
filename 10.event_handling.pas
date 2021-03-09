program Chapter8_SDL2;

uses SDL2;

var
sdlWindow1: PSDL_Window;
sdlEvent: PSDL_Event;
exitloop: boolean = false;
text1: string = '';

begin

  //initilization of video subsystem
  if SDL_Init( SDL_INIT_VIDEO ) < 0 then HALT;

  sdlWindow1 := SDL_CreateWindow( 'Window1', 50, 50, 500, 500, SDL_WINDOW_SHOWN );
  if sdlWindow1 = nil then HALT;

  new( sdlEvent );

  while exitloop = false do
  begin
    while SDL_PollEvent( sdlEvent ) = 1 do
    begin
      write( 'Event detected: ' );
      case sdlEvent^.type_ of

        //keyboard events
        SDL_KEYDOWN: begin
                       writeln( 'Key pressed:');
                       writeln( '  Key code: ', sdlEvent^.key.keysym.sym );
                       writeln( '  Key name: "', SDL_GetKeyName( sdlEvent^.key.keysym.sym ), '"' );
                       writeln( '  Scancode: ', sdlEvent^.key.keysym.scancode );
                       writeln( '  Scancode name: "', SDL_GetScancodeName( sdlEvent^.key.keysym.scancode ), '"' );
                       writeln( '  Key modifiers: ', sdlEvent^.key.keysym._mod );
                       case sdlEvent^.key.keysym.sym of
                         SDLK_ESCAPE: exitloop := true;  // exit on pressing ESC key

                         //switching text input mode on/off
                         SDLK_F1: begin
                                    if SDL_IsTextInputActive = SDL_True then SDL_StopTextInput
                                    else SDL_StartTextInput;
                                    writeln(' Text Input Mode switched' );
                                  end;
                       end;
                     end;
        SDL_KEYUP: writeln( 'Key released ' );
        SDL_TEXTINPUT: begin
                         writeln( 'Text input: "', sdlEvent^.text.text, '"' );
                         text1 := text1 + sdlEvent^.text.text;
                         writeln( 'Full string: ' + text1 );
                       end;

        //mouse events
        SDL_MOUSEMOTION: begin
                           writeln( 'X: ', sdlEvent^.motion.x, '   Y: ', sdlEvent^.motion.y,
                                    '   dX: ', sdlEvent^.motion.xrel, '   dY: ', sdlEvent^.motion.yrel );
                         end;
        SDL_MOUSEBUTTONDOWN: writeln( 'Mouse button pressed: Button index: ', sdlEvent^.button.button );
        SDL_MOUSEBUTTONUP: writeln( 'Mouse button released' );
        SDL_MOUSEWHEEL: begin
                          write( 'Mouse wheel scrolled: ' );
                          if sdlEvent^.wheel.y > 0 then writeln( 'Scroll forward, Y: ', sdlEvent^.wheel.y )
                          else writeln( 'Scroll backward, Y: ', sdlEvent^.wheel.y );
                        end;

        //window events
        SDL_WINDOWEVENT: begin
                           write( 'Window event: ' );
                           case sdlEvent^.window.event of
                             SDL_WINDOWEVENT_SHOWN: writeln( 'Window shown' );
                             SDL_WINDOWEVENT_MOVED: writeln( 'Window moved' );
                             SDL_WINDOWEVENT_MINIMIZED: writeln( 'Window minimized' );
                             SDL_WINDOWEVENT_MAXIMIZED: writeln( 'Window maximized' );
                             SDL_WINDOWEVENT_ENTER: writeln( 'Window got mouse focus' );
                             SDL_WINDOWEVENT_LEAVE: writeln( 'Window lost mouse focus' );
                           end;
                         end;
      end;
    end;
    SDL_Delay( 20 );
  end;
  
  dispose( sdlEvent );
  SDL_DestroyWindow ( sdlWindow1 );

  //shutting down video subsystem
  SDL_Quit;

end.
