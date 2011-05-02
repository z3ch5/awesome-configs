local setmetatable = setmetatable
local menu2 = require("customMenu.menu2")

module("customMenu.clientMenu")

-- local function hightlight(aWibox, value)
--   aWibox.bg = (value == true) and beautiful.bg_focus or beautiful.bg_normal
-- end

local aClient

function new(screen, args) 
  local function createMenu()
    local menu3 = { data = menu2() }
    
    function menu3:toggle(aClient2)
      aClient = aClient2
      menu3["data"]:toggle()
    end
    return menu3
  end
  
  mainMenu = createMenu()
  
  mainMenu["data"]:addItem("Visible",true,function()  end)
  mainMenu["data"]:addItem("Sticky",true,function()  end)
  mainMenu["data"]:addItem("Floating",true,function()  end)
  mainMenu["data"]:addItem("Maximized",true,function()  end)
  mainMenu["data"]:addItem("Master",true,function()  end)
  mainMenu["data"]:addItem("Move to tag",true,function()  end)
  mainMenu["data"]:addItem("Close",true,function()  end)
  mainMenu["data"]:addItem("Send Signal",true,function()  end)
  mainMenu["data"]:addItem("Renice",true,function()  end)

  return mainMenu
end
setmetatable(_M, { __call = function(_, ...) return new(...) end })