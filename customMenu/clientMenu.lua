local setmetatable = setmetatable
local menu2        = require("widgets.menu")
local beautiful    = require( "beautiful"                    )
local shifty    = require( "shifty"       )
local util    = require( "awful.util"                    )
local config = require("config")
local print = print
local ipairs = ipairs

local capi = {
               mouse = mouse,
               screen = screen,
               tag = tag,
             }

module("customMenu.clientMenu")

-- local function hightlight(aWibox, value)
--   aWibox.bg = (value == true) and beautiful.bg_focus or beautiful.bg_normal
-- end

local aClient
local mainMenu

local function listTags()
    function createTagList(aScreen)
        local tagList = menu2({autodiscard = true})
        local count = 0
        for _, v in ipairs(capi.screen[aScreen]:tags()) do
            tagList:add_item({text = v.name})
            count = count + 1
        end
        return tagList
    end
    if capi.screen.count() == 1 then
        return createTagList(1)
    else
        local screenSelect = menu2(({autodiscard = true}))
        for i=1, capi.screen.count() do
            screenSelect:add_item({text="Screen "..i , subMenu = createTagList(i)})
        end
        return screenSelect
    end
end

local function createNewTag_click(c1,c2,c3,screen)
    local t
    if not screen and capi.screen.count() > 1 then
        return nil
    elseif screen then
        t = shifty.add({name = aClient.name, screen = screen})
    else
        t = shifty.add({name = aClient.name, screen = 1})
    end
    if t and aClient then
        aClient:tags({t})
    end
end

local function createNewTag()
    if capi.screen.count() == 1 then
        return nil
    else
        return function()
            local screenSelect = menu2(({autodiscard = true}))
            for i=1, capi.screen.count() do
                screenSelect:add_item({text="Screen "..i , onclick = function() createNewTag_click(nil,nil,nil,i) end})
            end
            return screenSelect
        end
    end
end

local function initConf()
    if not config.data().persistent then config.data().persistent = {} end
    if not config.data().persistent.flags then config.data().persistent.flags = {} end
    if not config.data().persistent.flags.sticky    then config.data().persistent.flags.sticky    = {} end
    if not config.data().persistent.flags.floating  then config.data().persistent.flags.floating  = {} end
    if not config.data().persistent.flags.maximized then config.data().persistent.flags.maximized = {} end
    if not config.data().persistent.flags.above     then config.data().persistent.flags.above     = {} end
    if not config.data().persistent.flags.below     then config.data().persistent.flags.below     = {} end
    if not config.data().persistent.flags.onTop     then config.data().persistent.flags.onTop     = {} end
    if not config.data().persistent.flags.intrusive then config.data().persistent.flags.intrusive = {} end
end


local sigMenu = nil
local function singalMenu()
    if sigMenu then
        return sigMenu
    end
    sigMenu = menu2()
    sig0          = sigMenu:add_item({text="SIG0"             , onclick = function() util.spawn("kill -s 0       "..aClient.pid) end})
    sigalrm       = sigMenu:add_item({text="SIGALRM"          , onclick = function() util.spawn("kill -s ALRM    "..aClient.pid) end})
    sighup        = sigMenu:add_item({text="SIGHUP"           , onclick = function() util.spawn("kill -s HUP     "..aClient.pid) end})
    sigint        = sigMenu:add_item({text="SIGINT"           , onclick = function() util.spawn("kill -s INT     "..aClient.pid) end})
    sigkill       = sigMenu:add_item({text="SIGKILL"          , onclick = function() util.spawn("kill -s KILL    "..aClient.pid) end})
    sigpipe       = sigMenu:add_item({text="SIGPIPE"          , onclick = function() util.spawn("kill -s PIPE    "..aClient.pid) end})
    sigpoll       = sigMenu:add_item({text="SIGPOLL"          , onclick = function() util.spawn("kill -s POLL    "..aClient.pid) end})
    sigprof       = sigMenu:add_item({text="SIGPROF"          , onclick = function() util.spawn("kill -s PROF    "..aClient.pid) end})
    sigterm       = sigMenu:add_item({text="SIGTERM"          , onclick = function() util.spawn("kill -s TERM    "..aClient.pid) end})
    sigusr1       = sigMenu:add_item({text="SIGUSR1"          , onclick = function() util.spawn("kill -s USR1    "..aClient.pid) end})
    sigusr2       = sigMenu:add_item({text="SIGUSR2"          , onclick = function() util.spawn("kill -s USR2    "..aClient.pid) end})
    sigsigvtalrm  = sigMenu:add_item({text="SIGVTALRM"        , onclick = function() util.spawn("kill -s VTALRM  "..aClient.pid) end})
    sigstkflt     = sigMenu:add_item({text="SIGSTKFLT"        , onclick = function() util.spawn("kill -s STKFLT  "..aClient.pid) end})
    sigpwr        = sigMenu:add_item({text="SIGPWR"           , onclick = function() util.spawn("kill -s PWR     "..aClient.pid) end})
    sigwinch      = sigMenu:add_item({text="SIGWINCH"         , onclick = function() util.spawn("kill -s WINCH   "..aClient.pid) end})
    sigchld       = sigMenu:add_item({text="SIGCHLD"          , onclick = function() util.spawn("kill -s CHLD    "..aClient.pid) end})
    sigurg        = sigMenu:add_item({text="SIGURG"           , onclick = function() util.spawn("kill -s URG     "..aClient.pid) end})
    sigtstp       = sigMenu:add_item({text="SIGTSTP"          , onclick = function() util.spawn("kill -s TSTP    "..aClient.pid) end})
    sigttin       = sigMenu:add_item({text="SIGTTIN"          , onclick = function() util.spawn("kill -s TTIN    "..aClient.pid) end})
    sigttou       = sigMenu:add_item({text="SIGTTOU"          , onclick = function() util.spawn("kill -s TTOU    "..aClient.pid) end})
    sigstop       = sigMenu:add_item({text="SIGSTOP"          , onclick = function() util.spawn("kill -s STOP    "..aClient.pid) end})
    sigcont       = sigMenu:add_item({text="SIGCONT"          , onclick = function() util.spawn("kill -s CONT    "..aClient.pid) end})
    sigabrt       = sigMenu:add_item({text="SIGABRT"          , onclick = function() util.spawn("kill -s ABRT    "..aClient.pid) end})
    sigfpe        = sigMenu:add_item({text="SIGFPE"           , onclick = function() util.spawn("kill -s FPE     "..aClient.pid) end})
    sigill        = sigMenu:add_item({text="SIGILL"           , onclick = function() util.spawn("kill -s ILL     "..aClient.pid) end})
    sigquit       = sigMenu:add_item({text="SIGQUIT"          , onclick = function() util.spawn("kill -s QUIT    "..aClient.pid) end})
    sigsegv       = sigMenu:add_item({text="SIGSEGV"          , onclick = function() util.spawn("kill -s SEGV    "..aClient.pid) end})
    sigtrap       = sigMenu:add_item({text="SIGTRAP"          , onclick = function() util.spawn("kill -s TRAP    "..aClient.pid) end})
    sigsys        = sigMenu:add_item({text="SIGSYS"           , onclick = function() util.spawn("kill -s SYS     "..aClient.pid) end})
    sigemt        = sigMenu:add_item({text="SIGEMT"           , onclick = function() util.spawn("kill -s EMT     "..aClient.pid) end})
    sigbus        = sigMenu:add_item({text="SIGBUS"           , onclick = function() util.spawn("kill -s BUS     "..aClient.pid) end})
    sigxcpu       = sigMenu:add_item({text="SIGXCPU"          , onclick = function() util.spawn("kill -s XCPU    "..aClient.pid) end})
    sigxfsz       = sigMenu:add_item({text="SIGXFSZ"          , onclick = function() util.spawn("kill -s XFSZ    "..aClient.pid) end})
    return sigMenu
end

local layer_m = nil
function layerMenu()
    if layer_m then
        return layer_m
    end
    layer_m = menu2()
    
    layer_m:add_item({text="Normal"      , checked=true , onclick = function()  end})
    layer_m:add_item({text="Above"       , checked=true , onclick = function()  end})
    layer_m:add_item({text="Below"       , checked=true , onclick = function()  end})
    layer_m:add_item({text="On Top"      , checked=true , onclick = function()  end})
    
    return layer_m
end

function new(screen, args)
  initConf()
  mainMenu = menu2()
  itemVisible    = mainMenu:add_item({text="Visible"     , checked= function() if aClient ~= nil then return not aClient.hidden else return false end end, onclick = function()  end})
  itemVSticky    = mainMenu:add_item({text="Sticky"      , checked= function() if aClient ~= nil then return aClient.sticky else return false end end , onclick = function()  end})
  itemVFloating  = mainMenu:add_item({text="Floating"    , checked=true , onclick = function()  end})
  itemMaximized  = mainMenu:add_item({text="Maximized"   , checked=true , onclick = function()  end})
  itemMaster     = mainMenu:add_item({text="Master"      , checked=true , onclick = function()  end})
  itemMoveToTag  = mainMenu:add_item({text="Move to tag" , subMenu=listTags,})
  itemClose      = mainMenu:add_item({text="Close"       , onclick = function() if aClient ~= nil then  aClient:kill() end end})
  itemSendSignal = mainMenu:add_item({text="Send Signal" , subMenu = singalMenu(), onclick = function()  end})
  itemRenice     = mainMenu:add_item({text="Renice"      , checked=true , onclick = function()  end})
  itemNewTag     = mainMenu:add_item({text="Open in a new Tag"      , subMenu=createNewTag() , onclick = createNewTag_click})
  
  itemLayer     = mainMenu:add_item({text="Layer"       , subMenu=layerMenu(), onclick = function()  end})
  
  mainMenu_per = menu2()
  itemVSticky_per    = mainMenu_per:add_item({text="Sticky"      , checked= true , onclick = function() config.data()persistent.flags.sticky[aClient.class]   = not (config.data().persistent.flags.sticky[aClient.class]    or false) end})
  itemVFloating_per  = mainMenu_per:add_item({text="Floating"    , checked= true , onclick = function() config.data().persistent.flags.floating[aClient.class] = not (config.data().persistent.flags.floating[aClient.class]  or false) end})
  itemMaximized_per  = mainMenu_per:add_item({text="Maximized"   , checked= true , onclick = function() config.data().persistent.flags.maximized[aClient.class]= not (config.data().persistent.flags.maximized[aClient.class] or false) end})
  itemAbove_per      = mainMenu_per:add_item({text="Above"       , checked= true , onclick = function() config.data().persistent.flags.above[aClient.class]    = not (config.data().persistent.flags.above[aClient.class]     or false) end})
  itemBelow_per      = mainMenu_per:add_item({text="Below"       , checked= true , onclick = function() config.data().persistent.flags.below[aClient.class]    = not (config.data().persistent.flags.below[aClient.class]     or false) end})
  itemOntop_per      = mainMenu_per:add_item({text="On Top"      , checked= true , onclick = function() config.data().persistent.flags.onTop[aClient.class]    = not (config.data().persistent.flags.onTop[aClient.class]     or false) end})
  itemIntrusive_per  = mainMenu_per:add_item({text="Intrusive"   , checked= true , onclick = function() config.data().persistent.flags.intrusive[aClient.class]= not (config.data().persistent.flags.intrusive[aClient.class] or false) end})

  return mainMenu
end

function menu()
    return mainMenu or new()
end

function toggle(c)
    aClient = c
    if not itemVisible then
        new()
    end
    local mainMenu2 = menu2()
    mainMenu2:add_existing_item( itemVisible    )
    mainMenu2:add_existing_item( itemSticky     )
    mainMenu2:add_existing_item( itemFloating   )
    mainMenu2:add_existing_item( itemMaximized  )
    mainMenu2:add_existing_item( itemMaster     )
    mainMenu2:add_existing_item( itemLayer      )
    mainMenu2:add_existing_item( itemMoveToTag  )
    mainMenu2:add_existing_item( itemClose      )
    mainMenu2:add_existing_item( itemSendSignal )
    mainMenu2:add_existing_item( itemRenice     )
    mainMenu2:add_existing_item( itemNewTag     )
    if mainMenu then
        function classMenu(c)
            local classM = menu2()
            classM:add_item({text = "<b><tt>PERSISTENT</tt></b>",bg= beautiful.fg_normal,fg=beautiful.bg_normal,align="center"})
            classM:add_item({text = c.name})
            classM:add_item({text = "Intrusive"     })
            classM:add_item({text = "Match to Tags" })
            classM:add_item({text = "Flags", subMenu = function()
                local flagMenu = menu2()
                itemVSticky_per  :check(config.data().persistent.flags.sticky[aClient.class]    or false)
                itemVFloating_per:check(config.data().persistent.flags.floating[aClient.class]  or false)
                itemMaximized_per:check(config.data().persistent.flags.maximized[aClient.class] or false)
                itemAbove_per    :check(config.data().persistent.flags.above[aClient.class]     or false)
                itemBelow_per    :check(config.data().persistent.flags.below[aClient.class]     or false)
                itemOntop_per    :check(config.data().persistent.flags.onTop[aClient.class]     or false)
                itemIntrusive_per:check(config.data().persistent.flags.intrusive[aClient.class] or false)
                flagMenu:add_existing_item( itemVSticky_per    )
                flagMenu:add_existing_item( itemVFloating_per  )
                flagMenu:add_existing_item( itemMaximized_per  )
                flagMenu:add_existing_item( itemAbove_per      )
                flagMenu:add_existing_item( itemBelow_per      )
                flagMenu:add_existing_item( itemOntop_per      )
                flagMenu:add_existing_item( itemIntrusive_per  )
                return flagMenu
            end})
            return classM
        end
        
        mainMenu2.settings.x = c:geometry().x
        mainMenu2.settings.y = c:geometry().y+16
        mainMenu2:add_item({text = "<b><u>"..c.class.."</u></b>", subMenu = function() return classMenu(c) end, fg="#880000"})
        mainMenu2:toggle(true)
    end
end

setmetatable(_M, { __call = function(_, ...) return new(...) end })
