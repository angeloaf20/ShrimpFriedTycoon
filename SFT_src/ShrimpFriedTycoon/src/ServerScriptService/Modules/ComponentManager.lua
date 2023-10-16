--[[
    File: ComponentManager.lua
    Author: P4rad1gm/angeloaf20
    Description: Handles how components are locked/unlocked, adds components to the restaurant or restaurant storage
    Created: 10 October 2023
    Last modified: 15 October 2023
]]

--Services
local CollectionService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptStorage = game:GetService("ServerScriptService")

--Instances
local RestaurantStorage = ServerStorage.RestaurantStorage
local ComponentFolder = ServerScriptStorage.ComponentFolder

local TagConfig = {
	Decoration = "Decoration", 
	Button = "Buttons", 
	Production = "Production", 
	Teleporter = "Teleporters",
	SeatingArea = "SeatingAreas"
}

--Define ComponentManager class
local ComponentManager = {}
ComponentManager.__index = ComponentManager

function ComponentManager.new(restaurant)
	local self = setmetatable({}, ComponentManager)
	
	self.Restaurant = restaurant
	self._topicEvent = Instance.new("BindableEvent")	
	return self
end

function ComponentManager:Init()
	--print(typeof(self.Restaurant.restaurant))
	self:LockComponents(self.Restaurant.Building)
end

function ComponentManager:GetOwner()
	return self.Restaurant.Owner
end

function ComponentManager:SetOwner(owner)
	self.Restaurant.Owner = owner
	print(self.Restaurant.Owner.Parent)
end

function ComponentManager:Component(instance, componentScript)
	local compModule = require(componentScript)
	local newComp = compModule.new(self, instance)
	newComp:Init()
end

function ComponentManager:CreateComponents(instance)
	for _, tag in ipairs(CollectionService:GetTags(instance)) do
		local componentScript = ComponentFolder:FindFirstChild(tag)
		if componentScript then 
			self:Component(instance, componentScript)
		end
	end
end

--[[This is going to be more fleshed out later, 
but idea is that when a player logs in and they have already unlocked some stuff, then 
to load those in. For now it should only load in the "OpenRestaurant" buttons used to 
create a Restaurant object and unlock the restaurant building and its stuff.
]]
function ComponentManager:LoadUnlocks(instance)
	
end

function ComponentManager:LockComponents(model)
	for _, child in pairs(model:GetDescendants()) do
		if CollectionService:HasTag(child, "Unlockable") then
			self:Lock(child)
		else 
			self:CreateComponents(child)
		end
	end
end

function ComponentManager:Lock(instance)

	instance.Parent = RestaurantStorage
	self:Component(instance, ComponentFolder.Unlockable)
end

function ComponentManager:Unlock(instance, id)
	CollectionService:RemoveTag(instance, "Unlockable")
	
	local folder = instance:GetAttribute("Folder") or nil

	if folder ~= nil then instance.Parent = self.Restaurant.Building[folder] else instance.Parent = self.Restaurant.Building end

	self:CreateComponents(instance)
end

function ComponentManager:PublishTopic(topicName, ...)
	self._topicEvent:Fire(topicName, ...)
end

function ComponentManager:SubscribeTopic(topicName, callback)
	local connection = self._topicEvent.Event:Connect(function(name, ...)
		if name == topicName then
			callback(...)
		end
	end)
	return connection
end


return ComponentManager
