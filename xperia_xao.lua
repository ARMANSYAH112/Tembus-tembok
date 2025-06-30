-- XPERIA XAO MENU [FULL VERSION]
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local espObjects = {}
local flyConnection
local flying = false
local defaultWalkSpeed = hum.WalkSpeed

-- GUI
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "XPERIA_XAO"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 420)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔷 XPERIA XAO MENU"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16

-- Minimize
local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -30, 0, 3)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minBtn.TextColor3 = Color3.new(1, 1, 1)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 18

local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	for _, c in pairs(frame:GetChildren()) do
		if c ~= title and c ~= minBtn then
			c.Visible = not minimized
		end
	end
	frame.Size = minimized and UDim2.new(0, 240, 0, 35) or UDim2.new(0, 240, 0, 420)
end)

-- Tombol Builder
local function makeButton(name, order, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.Position = UDim2.new(0, 5, 0, 35 + order * 35)
	btn.Text = name .. ": OFF"
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 14

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = name .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
end

-- Noclip
makeButton("Noclip", 0, function(state)
	if state then
		game:GetService("RunService").Stepped:Connect(function()
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end)
	end
end)

-- ESP Base + Timer
makeButton("ESP Base", 1, function(state)
	for _, obj in pairs(espObjects) do if obj and obj.Parent then obj:Destroy() end end
	espObjects = {}

	if state then
		for _, b in pairs(workspace:GetChildren()) do
			if b.Name:lower():find("base") and b:FindFirstChild("Owner") and b.Owner.Value == plr then
				local box = Instance.new("BoxHandleAdornment", b)
				box.Adornee = b
				box.Size = b:GetExtentsSize()
				box.Color3 = Color3.fromRGB(0, 255, 0)
				box.Transparency = 0.4
				box.AlwaysOnTop = true
				box.ZIndex = 10
				box.Parent = b
				table.insert(espObjects, box)

				if b:FindFirstChild("Timer") then
					local gui = Instance.new("BillboardGui", b)
					gui.Name = "TimerESP"
					gui.Size = UDim2.new(0, 100, 0, 30)
					gui.StudsOffset = Vector3.new(0, 5, 0)
					gui.AlwaysOnTop = true

					local txt = Instance.new("TextLabel", gui)
					txt.Size = UDim2.new(1, 0, 1, 0)
					txt.BackgroundTransparency = 1
					txt.TextColor3 = Color3.fromRGB(0, 255, 0)
					txt.Font = Enum.Font.SourceSansBold
					txt.TextScaled = true
					txt.Text = b.Timer.Text

					gui.Adornee = b
					b.Timer:GetPropertyChangedSignal("Text"):Connect(function()
						txt.Text = b.Timer.Text
					end)

					table.insert(espObjects, gui)
				end
			end
		end
	end
end)

-- Speed
makeButton("Speed", 2, function(state)
	hum.WalkSpeed = state and 100 or defaultWalkSpeed
end)

-- Fly
makeButton("Fly", 3, function(state)
	if state then
		flying = true
		local bp = Instance.new("BodyPosition", char.HumanoidRootPart)
		bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		bp.P = 10000
		bp.D = 1000
		bp.Position = char.HumanoidRootPart.Position
		bp.Name = "XAO_Fly"
		bp.Parent = char.HumanoidRootPart

		flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
			bp.Position = char.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
		end)
	else
		flying = false
		if flyConnection then flyConnection:Disconnect() end
		if char.HumanoidRootPart:FindFirstChild("XAO_Fly") then
			char.HumanoidRootPart.XAO_Fly:Destroy()
		end
	end
end)

-- Auto Steal 5 Detik
makeButton("Auto Steal", 4, function(state)
	if state then
		local held = nil
		for _, tool in pairs(char:GetChildren()) do
			if tool:IsA("Tool") and tool.Name:lower():find("brainrot") then
				held = tool
				break
			end
		end

		if held then
			print("[XAO] Brainrot terdeteksi! Menunggu 5 detik...")
			wait(5)

			local base = nil
			for _, b in pairs(workspace:GetChildren()) do
				if b.Name:lower():find("base") and b:FindFirstChild("Owner") and b.Owner.Value == plr then
					base = b
					break
				end
			end

			if base and held:FindFirstChild("Handle") then
				held.Parent = workspace
				held.Handle.CFrame = base.CFrame + Vector3.new(0, 2, 0)
				print("[XAO] Brainrot dilempar ke base kamu!")
			else
				warn("[XAO] Gagal: base tidak ditemukan atau tool tidak lengkap.")
			end
		else
			warn("[XAO] Kamu tidak sedang memegang brainrot.")
		end
	end
end)

-- ESP Player (nama + box)
makeButton("ESP Player", 5, function(state)
	for _, obj in pairs(espObjects) do if obj and obj.Parent then obj:Destroy() end end
	if state then
		for _, p in pairs(game.Players:GetPlayers()) do
			if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = p.Character.HumanoidRootPart

				local box = Instance.new("BoxHandleAdornment", hrp)
				box.Adornee = hrp
				box.Size = Vector3.new(3, 6, 3)
				box.Color3 = Color3.fromRGB(0, 255, 0)
				box.Transparency = 0.4
				box.AlwaysOnTop = true
				box.ZIndex = 10
				table.insert(espObjects, box)

				local gui = Instance.new("BillboardGui", hrp)
				gui.Size = UDim2.new(0, 100, 0, 20)
				gui.StudsOffset = Vector3.new(0, 4, 0)
				gui.AlwaysOnTop = true

				local lbl = Instance.new("TextLabel", gui)
				lbl.Size = UDim2.new(1, 0, 1, 0)
				lbl.BackgroundTransparency = 1
				lbl.TextColor3 = Color3.fromRGB(0, 255, 0)
				lbl.Font = Enum.Font.SourceSansBold
				lbl.TextScaled = true
				lbl.Text = p.Name

				gui.Parent = hrp
				table.insert(espObjects, gui)
			end
		end
	end
end)
