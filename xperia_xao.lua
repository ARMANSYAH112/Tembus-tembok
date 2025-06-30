-- 🔷 XPERIA XAO LOADING
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- Loading Screen
local loadingGui = Instance.new("ScreenGui", CoreGui)
loadingGui.Name = "XPERIA_XAO_LOADING"
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

-- ✅ GUI Floating Menu
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "XPERIA_XAO_MENU"
local dragFrame = Instance.new("Frame", gui)
dragFrame.Size = UDim2.new(0, 200, 0, 140)
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

-- Toggle Buttons
local noclip = false
local esp = false
local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()

-- Noclip toggle
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
    if noclip and char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- ESP toggle
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
        if adorn then
            adorn:Destroy()
        end
    end
end

local function toggleESP(state)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if state then
                addESP(player.Character)
            else
                removeESP(player.Character)
            end
        end
    end
end

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
    toggleESP(esp)
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(1)
        if esp then
            addESP(char)
        end
    end)
end)

print("✅ XPERIA XAO | Menu Draggable + ESP + Noclip Aktif")
