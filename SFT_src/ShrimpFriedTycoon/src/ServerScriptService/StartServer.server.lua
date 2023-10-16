--[[
    File: StartServer.lua
    Author: P4rad1gm/angeloaf20
    Description: This script handles what happens when the server is loaded.
    Created: 9 October 2023
    Last modified: 13 October 2023
]]

--Services
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

--Modules
local Restaurant = require(ServerScriptService.Modules.Restaurant)
local ComponentManager = require(ServerScriptService.Modules.ComponentManager)

--Instances
local RestaurantSpawnLocations = workspace.RestaurantSpawnLocations
local RestaurantTemplate = ServerStorage.RestaurantTemplate
local RestaurantsInServer = workspace.RestaurantsInServer


for _, location in pairs(RestaurantSpawnLocations:GetChildren()) do
	
	local spawn = (location.CFrame * CFrame.new(0, -0.1, 0))
	local building = RestaurantTemplate:Clone()
	
	local newRestaurant = Restaurant.new(nil, building, spawn)
	newRestaurant:Init()
	
	
	local compManager = ComponentManager.new(newRestaurant)
	compManager:Init()
end

--for _, building in pairs (RestaurantsInServer:GetChildren()) do
	
--	local newRestaurant = Restaurant.new(nil, building)
--	newRestaurant:Init()
--	local compManager = ComponentManager.new(newRestaurant)
--	compManager:Init()
--end


