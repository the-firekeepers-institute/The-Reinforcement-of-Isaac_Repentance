--#region Main (Hello Isaac)
local mod = RegisterMod("Reinforcement of Isaac", 1)

local sfxManager = SFXManager()
local roundStartSfx = Isaac.GetSoundIdByName("Round Start")
local gameOverSfx = Isaac.GetSoundIdByName("Game Over")

sfxManager:Preload(roundStartSfx)
sfxManager:Preload(gameOverSfx)
--#endregion

--#region Callbacks
local function helloIsaac()
  print("[RoI] Hello, Isaac!" .. tostring(roundStartSfx))
  sfxManager:Play(roundStartSfx, 100)
end

--#region Inputs Callbacks
local function HandleUserInput()

end

local function CallAgentAction(entity, inputHook, buttonAction)
  -- Return bool when inputHook is Input.IsActionTriggered or Input.IsActionPressed, return float when inputHook is Input.IsActionValue
end
--#endregion

--#region Game Event Callbacks
local function GameStart(isContinued)
  print("[RoI] Welcome!! " .. tostring(roundStartSfx))
  sfxManager:Play(roundStartSfx, 100)
end

local function GameEnd(isLost)
  if isLost then
    print("[RoI] Failure... " .. tostring(gameOverSfx))
    sfxManager:Play(gameOverSfx, 100)
  end
end

local function GameExit(doSave)

end
--#endregion
--#endregion

-- HELLO ISAAC :D
mod:AddPriorityCallback(ModCallbacks.MC_POST_NEW_LEVEL, CallbackPriority.IMPORTANT, helloIsaac)

-- Frequent agent updates have 3 rates to use (the latter is used for overriding inputs):
-- * MC_POST_UPDATE -> 30 times per second (not when paused)
-- * MC_POST_RENDER -> 60 times per second (also when paused)
-- * MC_INPUT_ACTION -> ~49 times per logic step; called every time the game polls for a ButtonAction and can be used to change inputs.

mod:AddPriorityCallback(ModCallbacks.MC_POST_RENDER, CallbackPriority.IMPORTANT, HandleUserInput)
mod:AddPriorityCallback(ModCallbacks.MC_INPUT_ACTION, CallbackPriority.IMPORTANT, CallAgentAction)

-- Add agent triggers to start and stop reinforcement agents from the mod itself
mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.IMPORTANT, GameStart)
mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_END, CallbackPriority.IMPORTANT, GameEnd)
mod:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, CallbackPriority.IMPORTANT, GameExit)
