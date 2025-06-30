-- 🔷 XPERIA XAO LOADING
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- Loading screen
local loadingGui = Instance.new("ScreenGui", CoreGui)
local frame = Instance.new("Frame", loadingGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(0, 400, 0, 100)
label.Position = UDim2.new(0.5, -200, 0.5, -50)
label.Text = "🔷 XPERIA XAO"
label.Font = Enum.Font.GothamBlack
label.TextSize = 40
label.TextColor3 = Color3.fromRGB(0, 255, 255)
label.BackgroundTransparency = 1
wait(2)
loadingGui:Destroy()

-- UI MENU
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "XPERIA_XAO_MENU"
local dragFrame = Instance.new("Frame", gui)
dragFrame.Size = UDim2.new(0, 200, 0, 200)
dragFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
dragFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
dragFrame.Active = true
dragFrame.Draggable = true
dragFrame.BorderSizePixel = 2

local title = Instance.new("TextLabel", dragFrame)
title.Text = "🔷 XPERIA XAO MENU"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

-- Noclip
local noclip = false
local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local noclipBtn = Instance.new("TextButton", dragFrame)
noclipBtn.Size = UDim2.new(1, -20, 0, 30)
noclipBtn.Position = UDim2.new(0, 10, 0, 40)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
noclipBtn.TextColor3 = Color3.new(1, 1, 1)
noclipBtn.Font = Enum.Font.Gotham
noclipBtn.TextSize = 14

noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = "Noclip: " .. (noclip and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
    if noclip and localPlayer.Character then
        for _, part in pairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- ESP
local function addESP(target)
    for _, part in ipairs(target:GetDescendants()) do
        if part:IsA("BasePart") and not part:FindFirstChild("XperiaESP") then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "XperiaESP"
            box.Adornee = part
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Size = part.Size
            box.Color3 = Color3.new(0, 1, 0)
            box.Transparency = 0.7
            box.Parent = part
        end
    end
end

local function removeESP(target)
    for _, part in ipairs(target:GetDescendants()) do
        local adorn = part:FindFirstChild("XperiaESP")
        if adorn then adorn:Destroy() end
    end
end

local esp = false

local espBtn = Instance.new("TextButton", dragFrame)
espBtn.Size = UDim2.new(1, -20, 0, 30)
espBtn.Position = UDim2.new(0, 10, 0, 80)
espBtn.Text = "ESP: OFF"
espBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.Font = Enum.Font.Gotham
espBtn.TextSize = 14

espBtn.MouseButton1Click:Connect(function()
    esp = not esp
    espBtn.Text = "ESP: " .. (esp and "ON" or "OFF")
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if esp then addESP(player.Character)
            else removeESP(player.Character) end
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(1)
        if esp then addESP(char) end
    end)
end)

-- Speed Hack
local speed = false
local defaultWalkSpeed = 16
local speedValue = 80

local speedBtn = Instance.new("TextButton", dragFrame)
speedBtn.Size = UDim2.new(1, -20, 0, 30)
speedBtn.Position = UDim2.new(0, 10, 0, 120)
speedBtn.Text = "Speed: OFF"
speedBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedBtn.TextColor3 = Color3.new(1, 1, 1)
speedBtn.Font = Enum.Font.Gotham
speedBtn.TextSize = 14

speedBtn.MouseButton1Click:Connect(function()
    speed = not speed
    speedBtn.Text = "Speed: " .. (speed and "ON" or "OFF")
    local hum = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = speed and speedValue or defaultWalkSpeed
    end
end)

localPlayer.CharacterAdded:Connect(function(char)
    wait(1)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = speed and speedValue or defaultWalkSpeed
end)

-- Fly
local flying = false
local flySpeed = 5
local vel, gyro

local flyBtn = Instance.new("TextButton", dragFrame)
flyBtn.Size = UDim2.new(1, -20, 0, 30)
flyBtn.Position = UDim2.new(0, 10, 0, 160)
flyBtn.Text = "Fly: OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
flyBtn.TextColor3 = Color3.new(1, 1, 1)
flyBtn.Font = Enum.Font.Gotham
flyBtn.TextSize = 14

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = "Fly: " .. (flying and "ON" or "OFF")
    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    if flying then
        vel = Instance.new("BodyVelocity", hrp)
        gyro = Instance.new("BodyGyro", hrp)
        vel.Velocity = Vector3.zero
        vel.MaxForce = Vector3.new(9999, 9999, 9999)
        gyro.CFrame = hrp.CFrame
        gyro.MaxTorque = Vector3.new(9999, 9999, 9999)

        RunService.RenderStepped:Connect(function()
            if flying then
                local moveDir = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                vel.Velocity = moveDir.Unit * flySpeed
                gyro.CFrame = workspace.CurrentCamera.CFrame
            end
        end)
    else
        if vel then vel:Destroy() end
        if gyro then gyro:Destroy() end
    end
end)

-- Minimize system
local minimizeButton = Instance.new("TextButton", gui)
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(0, 10, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
minimizeButton.Text = "🔷"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.Visible = false

local closeBtn = Instance.new("TextButton", dragFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2)
closeBtn.Text = "-"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16

closeBtn.MouseButton1Click:Connect(function()
    dragFrame.Visible = false
    minimizeButton.Visible = true
end)

minimizeButton.MouseButton1Click:Connect(function()
    dragFrame.Visible = true
    minimizeButton.Visible = false
end)

print("✅ XPERIA XAO FULL | Menu, Noclip, ESP, Speed, Fly, Minimize Siap Bosku")
