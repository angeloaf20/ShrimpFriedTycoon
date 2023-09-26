local CollectionService = game:GetService("CollectionService")

local function CreatePrompt(instance, location)
	local ProximityPrompt = Instance.new("ProximityPrompt")
	ProximityPrompt.ActionText = "Go to " .. location
	ProximityPrompt.HoldDuration = 0.5
	ProximityPrompt.Parent = instance
end


local function findDestination(att)
	for _, TPBrick in pairs(CollectionService:GetTagged("Teleporter")) do
		if TPBrick:GetAttribute(att) then
			return TPBrick
		end
	end
	return
end


--for _, TPBrick in pairs(CollectionService:GetTagged("Teleporter")) do
--	local destination = TPBrick:GetAttribute("Destination")
--	CreatePrompt(TPBrick, destination)
--	if TPBrick.ProximityPrompt then
--		if game:GetService("Workspace").TycoonsInServer:WaitForChild("Restaurant") then
--			pcall(function()
--				TPBrick.ProximityPrompt.Triggered:Connect(function(player)
--					print("triggered")
--					-- Add your teleportation logic here
--				end)
--			end)
--		end
--	end

--end