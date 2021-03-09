program chap9_SDL2;
uses SDL2, SDL2_mixer;

var
sdlWindow1: PSDL_Window;
sdlEvent: PSDL_Event;
music: PMix_Music;
sound: PMix_Chunk;
exitloop: boolean = false;

begin
  if SDL_Init( SDL_INIT_VIDEO or SDL_INIT_AUDIO ) < 0 then HALT;

  //get a window
  sdlWindow1 := SDL_CreateWindow( 'Music and Sound window', 50, 50, 500, 500, SDL_WINDOW_SHOWN );
  if sdlWindow1 = nil then HALT;

  //prepare mixer
  if Mix_OpenAudio( MIX_DEFAULT_FREQUENCY, MIX_DEFAULT_FORMAT,
                    MIX_DEFAULT_CHANNELS, 4096 ) < 0 then HALT;

  //load music
  music := Mix_LoadMUS( 'sound/In-my-mind-1.ogg' );
  if music = nil then HALT;
  Mix_VolumeMusic( MIX_MAX_VOLUME );

  //load sound
  sound := Mix_LoadWAV( 'sound/dial-1.wav' );
  if sound = nil then HALT;
  Mix_VolumeChunk( sound, MIX_MAX_VOLUME );

  //create a menu
  writeln( '(1) Play music once' );
  writeln( '(2) Pause music' );
  writeln( '(3) Resume music' );
  writeln( '(4) Rewind music' );
  writeln( '(5) Play sound once on channel 1' );
  writeln( '(6) Play sound once on free channel' );
  writeln( '(7) Pause sound on all channels' );
  writeln( '(8) Resume sound on all channels' );
  writeln( '(A) Fade in music within 3 seconds' );
  writeln( '(S) Fade out music within 3 seconds from now' );
  writeln( '(D) Fade in sound on channel 1 within 2 seconds' );
  writeln( '(F) Fade out sound on channel 1 within 1 second from now' );
  writeln;
  writeln( '=== Effects on channel 1 ===' );
  writeln( '(G) Panning: left: 255, right: 32' );
  writeln( '(H) Stop panning' );
  writeln( '(J) Distance: very far ');
  writeln( '(K) Unregister distance effect' );
  writeln( '(L) Position 45ø to the right, in front, middle distance' );
  writeln( '(M) Unregister position effect' );
  writeln;
  writeln( '(ESC) Exit program' );

  new( sdlEvent );

  while exitloop = false do
  begin
    while SDL_PollEvent( sdlEvent ) = 1 do
    begin

      case sdlEvent^.type_ of
        SDL_KEYDOWN: begin
                       case sdlEvent^.key.keysym.sym of
                         SDLK_1: if Mix_PlayMusic( music, 0 ) < 0 then HALT;
                         SDLK_2: Mix_PauseMusic;
                         SDLK_3: Mix_ResumeMusic;
                         SDLK_4: Mix_RewindMusic;
                         SDLK_5: if Mix_PlayChannel( 1, sound, 0 ) < 0 then HALT;
                         SDLK_6: if Mix_PlayChannel( -1, sound, 0 ) < 0 then HALT;
                         SDLK_7: Mix_Pause( -1 );
                         SDLK_8: Mix_Resume( -1 );
                         SDLK_A: if Mix_FadeInMusic( music, 1, 3000 ) < 0 then HALT;
                         SDLK_S: if Mix_FadeOutMusic( 3000 ) = 0 then HALT;
                         SDLK_D: if Mix_FadeInChannel( 1, sound, 0, 2000 ) < 0 then HALT;
                         SDLK_F: if Mix_FadeOutChannel( 1, 1000 ) < 0 then HALT;
                         SDLK_G: if Mix_SetPanning( 1, 255, 32 ) = 0 then HALT;
                         SDLK_H: if Mix_SetPanning( 1, 255, 255 ) = 0 then HALT; //unregister panning
                         SDLK_J: if Mix_SetDistance( 1, 223 ) = 0 then HALT;
                         SDLK_K: if Mix_SetDistance( 1, 0 ) = 0 then HALT; //unregister distance effect
                         SDLK_L: if Mix_SetPosition( 1, 45, 127 ) = 0 then HALT;
                         SDLK_M: if Mix_SetPosition( 1, 0, 0 ) = 0 then HALT; //unregister position effect
                         SDLK_ESCAPE: exitloop := true;
                       end;
                     end;
      end;

    end;
    SDL_Delay( 5 );
  end;

  //clean up
  dispose( sdlEvent );
  SDL_DestroyWindow( sdlWindow1 );

  Mix_FreeMusic( music );
  Mix_FreeChunk( sound );

  Mix_CloseAudio;
  SDL_Quit;
end.
