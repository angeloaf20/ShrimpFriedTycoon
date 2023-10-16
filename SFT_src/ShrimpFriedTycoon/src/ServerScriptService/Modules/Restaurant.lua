--[[
    File: Restaurant.lua
    Author: P4rad1gm/angeloaf20
    Description: Defines the Restaurant class.
    Created: 9 October 2023
    Last modified: 15 October 2023
]]

--Services
local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")

--Instances
local RestaurantsInServer = Workspace.RestaurantsInServer
local RestaurantTemplate = ServerStorage.RestaurantTemplate

local function AddModel(model, modelCFrame)
	local newModel = model
	newModel:SetPrimaryPartCFrame(modelCFrame)
	newModel.Parent = RestaurantsInServer
end

-- Class: Restaurant
-- Description: Defines what a Restaurant object is. 
-- Parameters:
--   @param Player owner: Player who can make upgrades, accept investors, manager of the restaurant
--   @param CFrame spawn: Restaurant spawn location
local Restaurant = {}
Restaurant.__index = Restaurant

function Restaurant.new(owner, model, location)
	local self = setmetatable({}, Restaurant)
	self.Owner = owner
	self.Building = model
	self.Spawn = location
	return self
end

function Restaurant:Init()
	self.Building:SetAttribute("Owner", "")
	AddModel(self.Building, self.Spawn)
end

return Restaurant
