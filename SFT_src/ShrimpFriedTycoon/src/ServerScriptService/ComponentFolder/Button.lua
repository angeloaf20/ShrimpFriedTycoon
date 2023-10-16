--[[
    File: Button.lua
    Author: P4rad1gm/angeloaf20
    Description: Defines the Restaurant class.
    Created: 11 October 2023
    Last modified: 14 October 2023
]]
--Services
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

--Modules
local ComponentManager = require(ServerScriptService.Modules.ComponentManager)
local Restaurant = require(ServerScriptService.Modules.Restaurant)
local OwnerManager = require(ServerScriptService.Modules.OwnerManager)

local Button = {}
Button.__index = Button

function Button.new(compManager, instance)
	local self = setmetatable({}, Button)
	
	self.ComponentManager = compManager
	self.Instance = instance

	self.ButtonConfig = {
		Unlock = { --Unlocks items
			Action = function(player, button)
				local id = button:GetAttribute("Id")
				self.ComponentManager:PublishTopic("Button", id)
				button:Destroy()
			end
		},
		OpenRestaurant = { --Unlocks base components - buildings, first buttons, teleporters
			Action = function(player, button)
				if not OwnerManager.GetHasRestaurant(player) then
					local id = button:GetAttribute("Id")
					self.ComponentManager:PublishTopic("Button", id)
					self.ComponentManager:SetOwner(player)
					OwnerManager.SetHasRestaurant(player, true)
					button:Destroy()
				else
					warn(player, " already has a restaurant!")
				end
			end
		},
		BuyGamepass = { --Buys the gamepass items
			Action = function(player, button)
				-- Handle buy gamepass button action
			end,
		}
	}
	
	return self
end

function Button:Init()
	local action = self.Instance:GetAttribute("Action")
	self.Instance:FindFirstChild("TouchPart").Touched:Connect(function(hit)
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		if player and (self.ComponentManager:GetOwner() == player or self.ComponentManager:GetOwner() == nil) then
			local buttonConfig = self.ButtonConfig[action]
			buttonConfig.Action(player, self.Instance)
		end
		
	end)
end

function Button:TouchedButton(player)
	local id = self.Instance:GetAttribute("Id")
	self.ComponentManager:PublishTopic("Button", id)
	self.Instance:Destroy()
end

return Button
