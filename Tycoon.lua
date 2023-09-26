local CollectionService = game:GetService("CollectionService")
local PlayerManager = require(game:GetService("ServerScriptService").PlayerManager)
local Restaurant = game:GetService("ServerStorage").Restaurant
local RestaurantStorage = game:GetService("ServerStorage").RestaurantStorage
local TycoonsInServer = game:GetService("Workspace").TycoonsInServer
local Components = script.Parent.Components

local function NewModel(model, cframe)
	local newModel = model:Clone()
	newModel:PivotTo(cframe)
	newModel.Parent = game.Workspace.TycoonsInServer
	return newModel
end

local Tycoon = {}
Tycoon.__index = Tycoon

function Tycoon.new(player, spawnPoint)
	local self = setmetatable({}, Tycoon)
	self.Owner = player
	self.Parent = TycoonsInServer

	self._topicEvent = Instance.new("BindableEvent")	
	self._spawn = spawnPoint
	return self
end

function Tycoon:Init()
	self.Model = NewModel(Restaurant, self._spawn.CFrame)
	self.Owner:LoadCharacter()
	
	self:LockAll()
	self:LoadUnlocks()
	self:WaitForExit()	
end

function Tycoon:LoadUnlocks()
	for _, id in ipairs(PlayerManager.GetUnlockIds(self.Owner)) do
		self:PublishTopic("Button", id)
	end
end

function Tycoon:LockAll()
	for _, instance in ipairs(self.Model:GetDescendants()) do
		if CollectionService:HasTag(instance, "Unlockable") then
			self:Lock(instance)
		else
			self:AddComponents(instance)
		end
	end
end

function Tycoon:Lock(instance)
	instance.Parent = RestaurantStorage
	self:CreateComponent(instance, Components.Unlockable)
end

function Tycoon:Unlock(instance, id)
	PlayerManager.AddUnlockId(self.Owner, id)
	CollectionService:RemoveTag(instance, "Unlockable")
	self:AddComponents(instance)
	instance.Parent = self.Model
end

function Tycoon:AddComponents(instance)
	for _, tag in ipairs(CollectionService:GetTags(instance)) do
		local component = Components:FindFirstChild(tag)
		if component then 
			self:CreateComponent(instance, component)
		end
	end
end

function Tycoon:CreateComponent(instance, componentScript)
	local compModule = require(componentScript)
	local newComp = compModule.new(self, instance)
	newComp:Init()
end

function Tycoon:PublishTopic(topicName, ...)
	self._topicEvent:Fire(topicName, ...)
end

function Tycoon:SubscribeTopic(topicName, callback)
	local connection = self._topicEvent.Event:Connect(function(name, ...)
		if name == topicName then
			callback(...)
		end
	end)
	return connection
end

function Tycoon:WaitForExit()
	PlayerManager.PlayerRemoving:Connect(function(player)
		if self.Owner == player then
			self:Destroy()
		end
	end)
end

function Tycoon:Destroy()
	self.Model:Destroy()
	self._spawn:SetAttribute("Occupied", false)
	self._topicEvent:Destroy()
end

return Tycoon
