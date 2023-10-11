--[[
    File: Button.lua
    Author: P4rad1gm/angeloaf20
    Description: Defines the Restaurant class.
    Created: 11 October 2023
    Last modified:
]]

local Button = {}
Button.__index = Button

function Button.new(restaurant, instance)
	local self = setmetatable({}, Button)
	
	self.Restaurant = restaurant
	self.Instance = instance
	
	return self
end

function Button:Init()
	print("te")
	
end

function Button:TouchedButton()
	local id = self.Instance:GetAttribute("Id")
	self.Tycoon:PublishTopic("Button", id)
	self.Instance:Destroy()
end

return Button
