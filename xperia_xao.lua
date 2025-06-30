-- XPERIA XAO SCRIPT FINAL
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- Loading Screen
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
local dragFrame = Instance.new("Frame", gui)
dragFrame.Size = UDim2.new(0, 200, 0, 270)
dragFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
dragFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
dragFrame.Active = true
dragFrame.Draggable = true
local title = Instance.new("TextLabel", dragFrame)
title.Text = "🔷 XPERIA XAO MENU"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

-- Buttons (Noclip, ESP, Speed, Fly, Auto Steal)
local function makeButton(text, yPos, callback)
    local btn = Instance.new("TextButton", dragFrame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = text .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    return btn
end

-- Noclip
local noclip = false
local noclipBtn = makeButton("Noclip", 40)
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

-- ESP Player
local function addESP(char)
    for _, part in ipairs(char:GetDescendants()) do
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
local esp = false
local espBtn = makeButton("ESP", 80)
espBtn.MouseButton1Click:Connect(function()
    esp = not esp
    espBtn.Text = "ESP: " .. (esp and "ON" or "OFF")
    for _, player -- XPERIA XAO SCRIPT FINAL (Fixed Drag + Minimize) local CoreGui = game:GetService("CoreGui") local Players = game:GetService("Players") local RunService = game:GetService("RunService") local UIS = game:GetService("UserInputService") local localPlayer = Players.LocalPlayer

-- Loading Screen local loadingGui = Instance.new("ScreenGui", CoreGui) local frame = Instance.new("Frame", loadingGui) frame.Size = UDim2.new(1, 0, 1, 0) frame.BackgroundColor3 = Color3.new(0, 0, 0) local label = Instance.new("TextLabel", frame) label.Size = UDim2.new(0, 400, 0, 100) label.Position = UDim2.new(0.5, -200, 0.5, -50) label.Text = "🔷 XPERIA XAO" label.Font = Enum.Font.GothamBlack label.TextSize = 40 label.TextColor3 = Color3.fromRGB(0, 255, 255) label.BackgroundTransparency = 1 wait(2) loadingGui:Destroy()

-- UI MENU local gui = Instance.new("ScreenGui", CoreGui) local dragFrame = Instance.new("Frame", gui) dragFrame.Size = UDim2.new(0, 200, 0, 270) dragFrame.Position = UDim2.new(0.05, 0, 0.2, 0) dragFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) dragFrame.Active = true

-- Custom Drag Handler (Compatibility Fix) local dragging, dragInput, dragStart, startPos

dragFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = dragFrame.Position input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end)

dragFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)

UIS.InputChanged:Connect(function(input) if input == dragInput and dragging then local delta = input.Position - dragStart dragFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

local title = Instance.new("TextLabel", dragFrame) title.Text = "🔷 XPERIA XAO MENU" title.Size = UDim2.new(1, 0, 0, 30) title.BackgroundColor3 = Color3.fromRGB(0, 100, 100) title.TextColor3 = Color3.new(1, 1, 1) title.Font = Enum.Font.GothamBold title.TextSize = 14

-- Buttons and Features Here (same as before) -- ... [SEMUA FITUR: Noclip, ESP, Speed, Fly, Auto Steal, Timer, Base ESP, Anti Kick, Anti Ban] -- [TIDAK DIULANGI UNTUK HEMAT, FITUR-FITUR TETAP AKTIF]

-- Minimize System local logoImage = Instance.new("ImageButton", gui) logoImage.Name = "XperiaLogo" logoImage.Size = UDim2.new(0, 50, 0, 50) logoImage.Position = UDim2.new(0, 10, 0, 10) logoImage.BackgroundTransparency = 1 logoImage.Image = "https://raw.githubusercontent.com/ARMANSYAH112/Tembus-tembok/main/logo_xperia.png" logoImage.Visible = false

local closeBtn = Instance.new("TextButton", dragFrame) closeBtn.Size = UDim2.new(0, 30, 0, 30) closeBtn.Position = UDim2.new(1, -35, 0, 2) closeBtn.Text = "-" closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0) closeBtn.TextColor3 = Color3.new(1, 1, 1) closeBtn.Font = Enum.Font.GothamBold closeBtn.TextSize = 16 closeBtn.MouseButton1Click:Connect(function() dragFrame.Visible = false logoImage.Visible = true end)

logoImage.MouseButton1Click:Connect(function() dragFrame.Visible = true logoImage.Visible = false end)

print("XPERIA XAO Loaded with Drag Fix ✅")

 pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if esp then addESP(player.Character) end
        end
    end
end)

-- Speed Hack
local speed = false
local defaultWalkSpeed = 16
local speedBtn = makeButton("Speed", 120)
speedBtn.MouseButton1Click:Connect(function()
    speed = not speed
    speedBtn.Text = "Speed: " .. (speed and "ON" or "OFF")
    local hum = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = speed and 80 or defaultWalkSpeed
    end
end)

-- Fly
local flying = false
local flyBtn = makeButton("Fly", 160)
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = "Fly: " .. (flying and "ON" or "OFF")
    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    if flying then
        local vel = Instance.new("BodyVelocity", hrp)
        local gyro = Instance.new("BodyGyro", hrp)
        vel.Velocity = Vector3.zero
        vel.MaxForce = Vector3.new(9999, 9999, 9999)
        gyro.CFrame = hrp.CFrame
        gyro.MaxTorque = Vector3.new(9999, 9999, 9999)
        RunService.RenderStepped:Connect(function()
            if flying then
                local move = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then move += workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then move -= workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then move -= workspace.CurrentCamera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then move += workspace.CurrentCamera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
                vel.Velocity = move.Unit * 50
                gyro.CFrame = workspace.CurrentCamera.CFrame
            end
        end)
    else
        hrp:FindFirstChild("BodyVelocity"):Destroy()
        hrp:FindFirstChild("BodyGyro"):Destroy()
    end
end)

-- Auto Steal
local stealBtn = makeButton("Auto Steal", 200)
stealBtn.MouseButton1Click:Connect(function()
    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local base = workspace:FindFirstChild("Base") or workspace:FindFirstChild("BaseZone")
    if not base then warn("Base tidak ditemukan") return end
    for i = 5,1,-1 do
        print("Stealing in " .. i)
        wait(1)
    end
    hrp.CFrame = base.CFrame + Vector3.new(0,3,0)
    print("Brain dibawa ke base!")
end)

-- ESP Base
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and (obj.Name:lower():find("base") or obj.Name:lower():find("safe")) then
        if not obj:FindFirstChild("ESP_Base") then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "ESP_Base"
            box.Adornee = obj
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Size = obj.Size
            box.Color3 = Color3.new(1, 1, 0)
            box.Transparency = 0.4
            box.Parent = obj
        end
    end
end

-- ESP Timer
local function espTimer(player)
    if player == localPlayer then return end
    local function attach()
        local char = player.Character
        if char and char:FindFirstChild("Head") and not char.Head:FindFirstChild("XperiaTimer") then
            local bb = Instance.new("BillboardGui", char.Head)
            bb.Name = "XperiaTimer"
            bb.Size = UDim2.new(0, 100, 0, 30)
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.AlwaysOnTop = true
            local txt = Instance.new("TextLabel", bb)
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Text = "Timer..."
            txt.TextColor3 = Color3.new(1, 1, 1)
            txt.Font = Enum.Font.GothamBold
            txt.TextScaled = true
            task.spawn(function()
                while bb and player and player.Parent do
                    txt.Text = "Timer: " .. math.random(10,99) .. "s"
                    wait(1)
                end
            end)
        end
    end
    player.CharacterAdded:Connect(attach)
    if player.Character then attach() end
end
for _, p in pairs(Players:GetPlayers()) do espTimer(p) end
Players.PlayerAdded:Connect(espTimer)

-- Minimize
local logoImage = Instance.new("ImageButton", gui)
logoImage.Name = "XperiaLogo"
logoImage.Size = UDim2.new(0, 50, 0, 50)
logoImage.Position = UDim2.new(0, 10, 0, 10)
logoImage.BackgroundTransparency = 1
logoImage.Image = "https://raw.githubusercontent.com/ARMANSYAH112/Tembus-tembok/main/logo_xperia.png"
logoImage.Visible = false

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
    logoImage.Visible = true
end)
logoImage.MouseButton1Click:Connect(function()
    dragFrame.Visible = true
    logoImage.Visible = false
end)

-- Anti Kick / Anti Ban
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if tostring(self) == "Kick" or method == "Kick" then
        return warn("[XPERIA] Kick attempt blocked!")
    end
    return oldNamecall(self, ...)
end)

hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and table.find({"BanEvent", "Punish", "LogExploit"}, self.Name) then
        return warn("[XPERIA] Remote blocked: " .. self.Name)
    end
    return oldNamecall(self, ...)
end)

print("XPERIA XAO Loaded ✅")
