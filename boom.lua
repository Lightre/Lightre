local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local directions = {
	Vector3.new(1,0,0),
	Vector3.new(-1,0,0),
	Vector3.new(0,0,1),
	Vector3.new(0,0,-1),
	Vector3.new(1,0,1),
	Vector3.new(-1,0,-1),
	Vector3.new(-1,0,1),
	Vector3.new(1,0,-1),
}

local function start(character)
	local humanoid = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart")

	RunService.RenderStepped:Connect(function()
		camera.FieldOfView = math.random(25,120)
		camera.CFrame = camera.CFrame * CFrame.new(
			math.random(-10,10)/10,
			math.random(-10,10)/10,
			math.random(-10,10)/10
		)
	end)

	RunService.Heartbeat:Connect(function()
		humanoid.WalkSpeed = math.random(0,150)
		humanoid.Jump = true
		humanoid:Move(directions[math.random(1,#directions)], true)
		if math.random(1,10) == 1 then
			humanoid.PlatformStand = true
		else
			humanoid.PlatformStand = false
		end
	end)

	RunService.Stepped:Connect(function()
		humanoid.AutoRotate = false
		root.CFrame = root.CFrame * CFrame.Angles(
			0,
			math.rad(math.random(-180,180)),
			0
		)
	end)
end

if player.Character then
	start(player.Character)
end

player.CharacterAdded:Connect(start)