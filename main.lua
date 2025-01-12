-- Register the mod, which grants the ability to add code that correspond to in-game events (i.e. "callbacks").
local mod = RegisterMod("Hello Isaac", 1)

local function helloIsaac(npcEntity)
  print("Hello, Isaac!")
end

local function handleUserIntervention()

end

local function insertReinforcementAgentAction(entity, inputHook, buttonAction)
  -- Return bool when inputHook is Input.IsActionTriggered or Input.IsActionPressed, return float when inputHook is Input.IsActionValue
end

local function gameStart(isContinued)

end

local function gameEnd(isLost)

end

local function gameExit(doSave)

end

-- HELLO ISAAC :D
mod:AddPriorityCallback(ModCallbacks.MC_NPC_UPDATE, CallbackPriority.IMPORTANT, helloIsaac)

-- Frequent agent updates have 3 rates to use (the latter is used for overriding inputs):
-- * MC_POST_UPDATE -> 30 times per second (not when paused)
-- * MC_POST_RENDER -> 60 times per second (also when paused)
-- * MC_INPUT_ACTION -> ~49 times per logic step; called every time the game polls for a ButtonAction and can be used to change inputs.

mod:AddPriorityCallback(ModCallbacks.MC_POST_RENDER, CallbackPriority.IMPORTANT, handleUserIntervention)
mod:AddPriorityCallback(ModCallbacks.MC_INPUT_ACTION, CallbackPriority.IMPORTANT, insertReinforcementAgentAction)

-- Add agent triggers to start and stop reinforcement agents from the mod itself
mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.IMPORTANT, gameStart)
mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_END, CallbackPriority.IMPORTANT, gameEnd)
mod:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, CallbackPriority.IMPORTANT, gameExit)
