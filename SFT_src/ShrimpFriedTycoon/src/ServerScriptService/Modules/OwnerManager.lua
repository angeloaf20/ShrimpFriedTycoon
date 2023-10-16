--[[
    File: OwnerManager.lua
    Author: P4rad1gm/angeloaf20
    Description: Handles  money, rebirths, investments, etc of the owner.
    Created: 14 October 2023
    Last modified: 
]]


--Services
local Players = game:GetService("Players")


local OwnerManager = {}

function OwnerManager.Start()
    local OM_topicEvent = Instance.new("Bindable Event")
	Players.PlayerAdded:Connect(function(player)
		OwnerManager.SetHasRestaurant(player, false)
	end)
end

function OwnerManager.GetHasRestaurant(owner)
	return owner:GetAttribute("HasRestaurant")
end

function OwnerManager.SetHasRestaurant(owner, val)
	owner:SetAttribute("HasRestaurant", val)
    print(owner:GetAttribute("HasRestaurant"))
end


return OwnerManager
