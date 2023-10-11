--[[
    File: Unlockable.lua
    Author: P4rad1gm/angeloaf20
    Description: Handles how components are locked/unlocked, adds components to the restaurant or restaurant storage
    Created: 10 October 2023
    Last modified: 11 October 2023
]]

--Services
local ServerScriptService = game:GetService("ServerScriptService")

--Modules
local ComponentManager = require(ServerScriptService.ComponentManager)

local Unlockable = {}
Unlockable.__index = Unlockable

-- Constructor function for Unlockable objects
function Unlockable.new(compManager, instance)
	local self = setmetatable({}, Unlockable)
	self.ComponentManager = compManager
	self.Instance = instance

	return self
end

-- Initialize the Unlockable object
function Unlockable:Init()
	-- Subscribe to the "Button" topic and connect it to the OnButtonPressed function
	self.Subscription = self.ComponentManager:SubscribeTopic("Button", function(...)
		self:OnButtonPressed(...)
	end)
end

-- Handle the event when a button with a matching ID is pressed
function Unlockable:OnButtonPressed(id)
	-- Check if the pressed button's ID matches the Unlockable's UnlockId attribute
	if id == self.Instance:GetAttribute("UnlockId") then
		-- Unlock the Unlockable by moving it to the Restaurant's model
		self.ComponentManager:Unlock(self.Instance, id)

		-- Disconnect the subscription to the "Button" topic
		self.Subscription:Disconnect()
	end
end

-- Return the Unlockable class
return Unlockable