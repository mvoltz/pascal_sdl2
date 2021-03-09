program chap10_SDL2;
uses Classes, SysUtils, SDL2, GL, GLext;

const
  vertexShaderFile = 'VertexShader.txt';
  fragmentShaderFile = 'FragmentShader.txt';
  triangleData: array[0..8] of GLfloat = ( -1.0, -1.0, 0.0,
                                            1.0, -1.0, 0.0,
                                            0.0,  1.0, 0.0  );

var
sdlWindow1: PSDL_Window;
sdlGLContext1: TSDL_GLContext;
i: Word;
VertexArrayID: GLuint;
triangleVBO: GLuint;

VertexShaderID: GLuint;
VertexShaderCode: PGLchar;
FragmentShaderID: GLuint;
FragmentShaderCode: PGLchar;
ShaderCode: TStringList;
ProgramID: GLuint;
compilationResult: GLint = GL_FALSE;
InfoLogLength: GLint;
ErrorMessageArray: array of GLChar;

begin
  if SDL_Init( SDL_INIT_VIDEO ) < 0 then HALT;

  //get an OpenGL window and create OpenGL context
  sdlWindow1 := SDL_CreateWindow( 'OpenGL window', 50, 50, 500, 500, SDL_WINDOW_OPENGL );
  if sdlWindow1 = nil then HALT;

  sdlGLContext1 := SDL_GL_CreateContext( sdlWindow1 );
  if @sdlGLContext1 = nil then HALT;

  //init OpenGL and load extensions
  if Load_GL_VERSION_4_0 = false then
    if Load_GL_VERSION_3_3 = false then
      if Load_GL_VERSION_3_2 = false then
        if Load_GL_VERSION_3_0 = false then
        begin
          writeln(' ERROR: OpenGL 3.0 or higher needed. '); readln;
          HALT;
        end;

  //print out OpenGL vendor, version and shader version
  writeln( 'Vendor: ' + glGetString( GL_VENDOR ) );
  writeln( 'OpenGL Version: ' + glGetString( GL_VERSION ) );
  writeln( 'Shader Version: ' + glGetString( GL_SHADING_LANGUAGE_VERSION ) );

  //create Vertex Array Object (VAO)
  glGenVertexArrays( 1, @VertexArrayID );
  glBindVertexArray( VertexArrayID );

  //creating Vertex Buffer Object (VBO)
  glGenBuffers( 1, @triangleVBO );
  glBindBuffer( GL_ARRAY_BUFFER, triangleVBO );
  glBufferData( GL_ARRAY_BUFFER, SizeOf( triangleData ), @triangleData, GL_STATIC_DRAW );

  //creating shaders
  VertexShaderID := glCreateShader( GL_VERTEX_SHADER );
  FragmentShaderID := glCreateShader( GL_FRAGMENT_SHADER );

  //load shader code and get PChars
  ShaderCode := TStringList.Create;
  ShaderCode.LoadFromFile( VertexShaderFile );
  VertexShaderCode := ShaderCode.GetText;
  if VertexShaderCode = nil then HALT;
  ShaderCode.LoadFromFile( FragmentShaderFile );
  FragmentShaderCode := ShaderCode.GetText;
  if FragmentShaderCode = nil then HALT;
  ShaderCode.Free;

  //compiling and error checking vertex shader
  write('Compiling and error checking Vertex Shader... ' );
  glShaderSource( VertexShaderID, 1, @VertexShaderCode, nil );
  glCompileShader( VertexShaderID );

  glGetShaderiv( VertexShaderID, GL_COMPILE_STATUS, @compilationResult );
  glGetShaderiv( VertexShaderID, GL_INFO_LOG_LENGTH, @InfoLogLength );
  if compilationResult = GL_FALSE then
  begin
    writeln( 'failure' );
    SetLength( ErrorMessageArray, InfoLogLength+1 );
    glGetShaderInfoLog( VertexShaderID, InfoLogLength, nil, @ErrorMessageArray[0] );
    for i := 0 to InfoLogLength do write( String( ErrorMessageArray[i] ) );
    writeln;
  end else writeln( 'success' );

  //compiling and error checking fragment shader
  write('Compiling and error checking Fragment Shader... ' );
  glShaderSource( FragmentShaderID, 1, @FragmentShaderCode, nil );
  glCompileShader( FragmentShaderID );

  glGetShaderiv( FragmentShaderID, GL_COMPILE_STATUS, @compilationResult );
  glGetShaderiv( FragmentShaderID, GL_INFO_LOG_LENGTH, @InfoLogLength );
  if compilationResult = GL_FALSE then
  begin
    writeln( 'failure' );
    SetLength( ErrorMessageArray, InfoLogLength+1 );
    glGetShaderInfoLog( VertexShaderID, InfoLogLength, nil, @ErrorMessageArray[0] );
    for i := 0 to InfoLogLength do write( String( ErrorMessageArray[i] ) );
    writeln;
  end else writeln( 'success' );

  //creating and linking program
  write('Creating and linking program... ' );
  ProgramID := glCreateProgram();
  glAttachShader( ProgramID, VertexShaderID );
  glAttachShader( ProgramID, FragmentShaderID );
  glLinkProgram( ProgramID );

  glGetShaderiv( ProgramID, GL_LINK_STATUS, @compilationResult );
  glGetShaderiv( ProgramID, GL_INFO_LOG_LENGTH, @InfoLogLength );
  if compilationResult = GL_FALSE then
  begin
    writeln( 'failure' );
    SetLength( ErrorMessageArray, InfoLogLength+1 );
    glGetShaderInfoLog( VertexShaderID, InfoLogLength, nil, @ErrorMessageArray[0] );
    for i := 0 to InfoLogLength do write( String( ErrorMessageArray[i] ) );
    writeln;
  end else writeln( 'success' );

  for i := 0 to 400 do
  begin
    glClearColor( 0.0, 1.0-i/400, 0.0+i/400, 1.0 );
    glClear( GL_COLOR_BUFFER_BIT );
    glUseProgram( ProgramID );
    glEnableVertexAttribArray( 0 );
    glBindBuffer( GL_ARRAY_BUFFER, triangleVBO );
    glVertexAttribPointer( 0, 3, GL_FLOAT, GL_FALSE, 0, nil );
    glDrawArrays( GL_TRIANGLES, 0, 3 );
    glDisableVertexAttribArray( 0 );
    SDL_Delay( 20 );
    SDL_GL_SwapWindow( sdlWindow1 );
  end;

  //clean up
  glDetachShader( ProgramID, VertexShaderID );
  glDetachShader( ProgramID, FragmentShaderID );

  glDeleteShader( VertexShaderID );
  glDeleteShader( FragmentShaderID );
  glDeleteProgram( ProgramID );

  StrDispose( VertexShaderCode );
  StrDispose( FragmentShaderCode );

  glDeleteBuffers( 1, @triangleVBO );
  glDeleteVertexArrays( 1, @VertexArrayID );

  SDL_GL_DeleteContext( sdlGLContext1 );
  SDL_DestroyWindow( sdlWindow1 );

  SDL_Quit;
end.
