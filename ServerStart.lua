--[[
    File: StartServer.lua
    Author: P4rad1gm/angeloaf20
    Description: This script handles what happens when the server is loaded.
    Created: 9 October 2023
    Last modified: 11 October 2023
]]

--Services
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

--Modules
local Restaurant = require(ServerScriptService.Restaurant)
local ComponentManager = require(ServerScriptService.ComponentManager)

--Instances
local RestaurantSpawnLocations = workspace.RestaurantSpawnLocations
local RestaurantsInServer = workspace.RestaurantsInServer


for _, location in pairs(RestaurantSpawnLocations:GetChildren()) do
	
	local owner = nil
	local spawn = (location.CFrame * CFrame.new(0, -0.3, 0))
	
	local newRestaurant = Restaurant.new(owner, spawn)
	newRestaurant:Init()
	
	local compManager = ComponentManager.new(newRestaurant)
	compManager:Init()
end
