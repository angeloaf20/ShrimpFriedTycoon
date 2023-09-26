local TycoonLocations = game:GetService("Workspace").TycoonSpawnLocations

local NewTycoonSpot = {}

function NewTycoonSpot.Start()
	for _, location in ipairs(TycoonLocations:GetChildren()) do
		if not location:GetAttribute("Occupied") then
			return location
		end
	end
end

return NewTycoonSpot
