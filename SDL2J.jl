module SDL

import Libdl

sdl = dlopen("libSDL2")
sdl_gfx = dlopen("libSDL2_gfx")

SDL_GetError = dlsym(sdl, :SDL_GetError)
SDL_Init = dlsym(sdl, :SDL_Init)
SDL_CreateWindow = dlsym(sdl, :SDL_CreateWindow)

initTimer = convert(Cuint, 0x00000001)
initAudio = convert(Cuint, 0x00000010)
initVideo = convert(Cuint, 0x00000020)
initJoystick = convert(Cuint, 0x00000200)
initHaptic = convert(Cuint, 0x00001000)
initGameController = convert(Cuint, 0x00002000)
initEvents = convert(Cuint, 0x00004000)
initNoParachute = convert(Cuint, 0x00100000)
initEverything = initTimer | initAudio | initVideo | initEvents | initJoystick | initHaptic | initGameController

"""
    SDL.getError()::string

Get error from the SDL library. Returns a string of the error.

See https://wiki.libsdl.org/SDL_GetError

# Examples
```julia
julia> include("SDL2J")
julia> SDL.getError()
"Some error message"
```
"""
function getError()
    return ccall(SDL_GetError, Cstring)
end

"""
    SDL.init(f)

Initialize SDL library and returns `true` for success and `false` if it fails. Takes 1 or more flags, bitwise ored together.

See https://wiki.libsdl.org/SDL_Init

# Examples
```julia
julia> include("SDL2J")
julia> SDL.init(SDL.initVideo)
true
```
```julia-repl
julia> include("SDL2J")
julia> SDL.init(SDL.initVideo | SDL.initTimer)
true
```
"""
function init(f::Cuint)
    return ccall(SDL_Init, Cuint, (Cuint,), f) == 0
end

function createWindow()
    return ccall(SDL_CreateWindow, )
end

end
