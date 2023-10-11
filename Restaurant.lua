--[[
    File: Restaurant.lua
    Author: P4rad1gm/angeloaf20
    Description: Defines the Restaurant class.
    Created: 9 October 2023
    Last modified: 11 October 2023
]]

--Services
local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")

--Instances
local RestaurantsInServer = Workspace.RestaurantsInServer
local RestaurantTemplate = ServerStorage.RestaurantTemplate

local function AddModel(model, modelCFrame)
	local newModel = model:Clone()
	newModel:SetPrimaryPartCFrame(modelCFrame)
	newModel.Parent = RestaurantsInServer
	return newModel
end

-- Class: Restaurant
-- Description: Defines what a Restaurant object is. 
-- Parameters:
--   @param Player owner: Player who can make upgrades, accept investors, manager of the restaurant
--   @param CFrame spawn: Restaurant spawn location
local Restaurant = {}
Restaurant.__index = Restaurant

function Restaurant.new(owner: Player, spawnLocation: CFrame)
	local self = setmetatable({}, Restaurant)
	self.Owner = owner
	self.spawn = spawnLocation
	return self
end

function Restaurant:Init()
	self.Building = AddModel(RestaurantTemplate, self.spawn)
end

return Restaurant
