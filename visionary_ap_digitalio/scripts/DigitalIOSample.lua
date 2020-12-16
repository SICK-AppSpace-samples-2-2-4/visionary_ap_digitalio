--[[----------------------------------------------------------------------------

  Showing basic functionality for using the IO ports.

------------------------------------------------------------------------------]]

--luacheck: globals gTimer

local currentDout2State = false

-- Some digital ports are input only, while others are
-- bidirectional. The direction of a bidirectional digital
-- port is set by using different create() methods.

-- Initialize digital in/out 1 to be an input
local din_1 = Connector.DigitalIn.create('DI1')

-- Initialize digital in/out 2 to be an output
local dout_2 = Connector.DigitalOut.create('DO2')

-- Add a timer which changes the state of dout_2 once a second
gTimer = Timer.create()
Timer.setPeriodic(gTimer, true)
Timer.setExpirationTime(gTimer, 1000)
Timer.start(gTimer)

-- Toggle the state of dout_2 with every timer expiration
--@toggleDout2State()
local function toggleDout2State()
  currentDout2State = not currentDout2State
  Connector.DigitalOut.set(dout_2, currentDout2State)
  print('Digital I/O 2 changed state to ' .. tostring(currentDout2State))
end
Timer.register(gTimer, 'OnExpired', toggleDout2State)

-- To track the changing value of an input, register a callback on
-- the OnChange event of the DI1 port.
--@printDin1State(newState:bool)
local function printDin1State(newState)
  print('Digital I/O 1 changed state to ' .. tostring(newState))
end
Connector.DigitalIn.register(din_1, 'OnChange', printDin1State)
