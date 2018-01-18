module SDL

sdl = Libdl.dlopen("libSDL2")
sdl_gfx = Libdl.dlopen("libSDL2_gfx")

SDL_GetError = Libdl.dlsym(sdl, :SDL_GetError)
SDL_Init = Libdl.dlsym(sdl, :SDL_Init)
SDL_CreateWindow = Libdl.dlsym(sdl, :SDL_CreateWindow)

"""
timer subsystem
"""
const InitTimer = convert(Cuint, 0x00000001)
"""
audio subsystem
"""
const InitAudio = convert(Cuint, 0x00000010)
"""
video subsystem; automatically initializes the events subsystem
"""
const InitVideo = convert(Cuint, 0x00000020)
"""
joystick subsystem; automatically initializes the events subsystem
"""
const InitJoystick = convert(Cuint, 0x00000200)
"""
haptic (force feedback) subsystem
"""
const InitHaptic = convert(Cuint, 0x00001000)
"""
controller subsystem; automatically initializes the joystick subsystem
"""
const InitGameController = convert(Cuint, 0x00002000)
"""
events subsystem
"""
const InitEvents = convert(Cuint, 0x00004000)
"""
compatibility; this flag is ignored
"""
const InitNoParachute = convert(Cuint, 0x00100000)
"""
all of the above subsystems
"""
const InitEverything = InitTimer | InitAudio | InitVideo | InitEvents | InitJoystick | InitHaptic | InitGameController

"""
fullscreen window
"""
const WindowFullscreen = convert(Cuint, 0x00000001)
"""
window usable with OpenGL context
"""
const WindowOpenGL = convert(Cuint, 0x00000002)
"""
window is visible
"""
const WindowShown = convert(Cuint, 0x00000004)
"""
window is not visible
"""
const WindowHidden = convert(Cuint, 0x00000008)
"""
no window decoration
"""
const WindowBorderless = convert(Cuint, 0x00000010)
"""
window can be resized
"""
const WindowResizable = convert(Cuint, 0x00000020)
"""
window is minimized
"""
const WindowMinimized = convert(Cuint, 0x00000040)
"""
window is maximized
"""
const WindowMaximized = convert(Cuint, 0x00000080)
"""
window has grabbed input focus
"""
const WindowInputGrabbed = convert(Cuint, 0x00000100)
"""
window has input focus
"""
const WindowInputFocus = convert(Cuint, 0x00000200)
"""
window has mouse focus
"""
const WindowMouseFocus = convert(Cuint, 0x00000400)

const WindowFullscreenDesktop = ( WindowFullscreen | convert(Cuint, 0x00001000) )
"""
window not created by SDL
"""
const WindowForeign = convert(Cuint, 0x00000800)
"""
window should be created in high-DPI mode if supported
"""
const WindowAllowHighDPI = convert(Cuint, 0x00002000)
"""
window has mouse captured (unrelated to InputGrabbed)
"""
const WindowMouseCapture = convert(Cuint, 0x00004000)
"""
window should always be above others
"""
const WindowAlwaysOnTop = convert(Cuint, 0x00008000)
"""
window should not be added to the taskbar
"""
const WindowSkipTaskbar = convert(Cuint, 0x00010000)
"""
window should be treated as a utility window
"""
const WindowUtility = convert(Cuint, 0x00020000)
"""
window should be treated as a tooltip
"""
const WindowTooltip = convert(Cuint, 0x00040000)
"""
window should be treated as a popup menu
"""
const WindowPopupMenu = convert(Cuint, 0x00080000)
"""
window usable for Vulkan surface
"""
const WindowVulkan = convert(Cuint, 0x10000000)

mutable struct SDL_Window
end

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
    SDL.init(flag [, flags...])

Initialize SDL library and returns `true` for success and `false` if it fails. Takes 1 or more flags.

See https://wiki.libsdl.org/SDL_Init

# Examples
```julia
julia> include("SDL2J")
julia> SDL.init(SDL.InitVideo)
true
```
```julia-repl
julia> include("SDL2J")
julia> SDL.init(SDL.InitVideo, SDL.InitAudio)
true
```
"""
function init(flags...)
    ccall(
        SDL_Init,
        Cuint,
        (Cuint,),
        reduce(|, flags)
    ) == 0
end

function createWindow(title, x, y, width, height, flags...)
    ccall(
        SDL_CreateWindow,
        Ref{SDL_Window},
        (Cstring, Cint, Cint, Cint, Cint, Cuint),
        title,
        x,
        y,
        width,
        height,
        reduce(|, flags)
    )
end

end
