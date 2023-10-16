--[[
    File: Telporter.lua
    Author: P4rad1gm/angeloaf20
    Description: Defines the Teleporter class.
    Created: 14 October 2023
    Last modified: 15 October 2023
]]

--Services
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

--Modules
local ComponentManager = require(ServerScriptService.Modules.ComponentManager)


local COOLDOWN = 5 --how long to wait until can teleport again


local Teleporter = {}
Teleporter.__index = Teleporter

function Teleporter.new(compManager, instance)
	
	local self = setmetatable({}, Teleporter)
	self.ComponentManager = compManager
	self.Instance = instance
	self.CanTeleport = true  -- Flag to track if the player can teleport
	return self
end

function Teleporter:Init()
	
	local A = self.Instance.Parent:WaitForChild("A")
	local B = self.Instance.Parent:WaitForChild("B")
	
	A.ProximityPrompt.Triggered:Connect(function(player)
		self:StartTeleport(B, player)
	end)
	
	B.ProximityPrompt.Triggered:Connect(function(player)
		self:StartTeleport(A, player)
	end)


end

function Teleporter:StartTeleport(target, player)
	if target and self.CanTeleport then
		player.Character:PivotTo(target.CFrame * CFrame.new(0, 1.5, 0))
		self.CanTeleport = false
		wait(COOLDOWN)
		self.CanTeleport = true
	else
		print("Teleport failed: Invalid target or teleportation in progress.")
	end
end


return Teleporter
