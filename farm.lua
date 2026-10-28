-- Delta Executor Ultimate PC Auto-Farm (v19.1 - Instant Text Key Fix)
-- Access License Key: farmedit (No need to press Enter, unlocks automatically)

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local secretKey = "farmedit"
local farmActive = false
local farmDelay = 0.8

local parentGui = game:GetService("CoreGui")
if parentGui:FindFirstChild("EliteCoreFarmUI") then
    parentGui["EliteCoreFarmUI"]:Destroy()
end

player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end)

-- Main GUI Layout Frame
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EliteCoreFarmUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = parentGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.05, 0, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(255, 140, 0)
borderStroke.Thickness = 2
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
titleLabel.Text = "   ASTRONAUT ENGINE [PC v19.1]"
titleLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- =======================================================
-- MASK SECURITY LOCK
-- =======================================================
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(1, 0, 1, -40)
keyFrame.Position = UDim2.new(0, 0, 0, 40)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyFrame.BorderSizePixel = 0
keyFrame.ZIndex = 5
keyFrame.Parent = mainFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 10)
keyCorner.Parent = keyFrame

local keyNotice = Instance.new("TextLabel")
keyNotice.Size = UDim2.new(1, -30, 0, 40)
keyNotice.Position = UDim2.new(0, 15, 0, 20)
keyNotice.BackgroundTransparency = 1
keyNotice.Text = "ENTER SECURITY KEY:"
keyNotice.TextColor3 = Color3.fromRGB(180, 180, 190)
keyNotice.Font = Enum.Font.SourceSansBold
keyNotice.TextSize = 14
keyNotice.ZIndex = 5
keyNotice.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -40, 0, 35)
keyInput.Position = UDim2.new(0, 20, 0, 75)
keyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
keyInput.Text = ""
keyInput.PlaceholderText = "Type key here..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 14
keyInput.ZIndex = 5
keyInput.Parent = keyFrame

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 6)
keyInputCorner.Parent = keyInput

local keyInputStroke = Instance.new("UIStroke")
keyInputStroke.Color = Color3.fromRGB(50, 50, 60)
keyInputStroke.Thickness = 1
keyInputStroke.Parent = keyInput

-- =======================================================
-- AUTOMATION HUD
-- =======================================================
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 25)
statusLabel.Position = UDim2.new(0, 15, 0, 50)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "SYSTEM STATUS: ACTIVE [READY]"
statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
statusLabel.Font = Enum.Font.SourceSansSemibold
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

local speedConfigLabel = Instance.new("TextLabel")
speedConfigLabel.Size = UDim2.new(0, 140, 0, 30)
speedConfigLabel.Position = UDim2.new(0, 15, 0, 85)
speedConfigLabel.BackgroundTransparency = 1
speedConfigLabel.Text = "TELEPORT INTERVAL (s):"
speedConfigLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
speedConfigLabel.Font = Enum.Font.SourceSansBold
speedConfigLabel.TextSize = 13
speedConfigLabel.TextXAlignment = Enum.TextXAlignment.Left
speedConfigLabel.Parent = mainFrame

local speedConfigInput = Instance.new("TextBox")
speedConfigInput.Size = UDim2.new(0, 70, 0, 30)
speedConfigInput.Position = UDim2.new(0, 215, 0, 85)
speedConfigInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
speedConfigInput.Text = "0.8"
speedConfigInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedConfigInput.Font = Enum.Font.SourceSansBold
speedConfigInput.TextSize = 14
speedConfigInput.ClearTextOnFocus = false

local speedConfigCorner = Instance.new("UICorner")
speedConfigCorner.CornerRadius = UDim.new(0, 6)
speedConfigCorner.Parent = speedConfigInput

local speedConfigStroke = Instance.new("UIStroke")
speedConfigStroke.Color = Color3.fromRGB(50, 50, 60)
speedConfigStroke.Thickness = 1
speedConfigStroke.Parent = speedConfigInput
speedConfigInput.Parent = mainFrame

speedConfigInput.FocusLost:Connect(function()
    local val = tonumber(speedConfigInput.Text)
    if val and val >= 0 then
        farmDelay = val
    else
        speedConfigInput.Text = tostring(farmDelay)
    end
end)

local hotkeyFarmInfo = Instance.new("TextLabel")
hotkeyFarmInfo.Size = UDim2.new(1, -30, 0, 25)
hotkeyFarmInfo.Position = UDim2.new(0, 15, 0, 135)
hotkeyFarmInfo.BackgroundTransparency = 1
hotkeyFarmInfo.Text = "-> Press KEYBOARD [ M ] to Toggle Farm ON/OFF"
hotkeyFarmInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
hotkeyFarmInfo.Font = Enum.Font.SourceSans
hotkeyFarmInfo.TextSize = 13
hotkeyFarmInfo.TextXAlignment = Enum.TextXAlignment.Left
hotkeyFarmInfo.Parent = mainFrame

-- Helper Scanning Functions
local function getTargets(name)
    local targets = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == name then
            table.insert(targets, obj)
        end
    end
    return targets
end

local function getClosestTarget(list, hrp)
    local closest = nil
    local shortestDistance = math.huge
    for _, item in ipairs(list) do
        if item and item.Parent and hrp then
            local distance = (hrp.Position - item.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closest = item
            end
        end
    end
    return closest
end

-- Ultra High-Frequency Proximity Prompt Trigger
local function triggerPrompt(prompt)
    if fireproximityprompt then
        fireproximityprompt(prompt)
    else
        task.spawn(function()
            prompt:InputBegan(Enum.UserInputType.Keyboard)
            task.wait(0.01)
            prompt:InputEnded(Enum.UserInputType.Keyboard)
        end)
    end
end

local function updateUIStatus()
    if farmActive then
        statusLabel.Text = "SYSTEM STATUS: RUNNING [FARM ACTIVE]"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        borderStroke.Color = Color3.fromRGB(0, 255, 120)
    else
        statusLabel.Text = "SYSTEM STATUS: ACTIVE [READY]"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        borderStroke.Color = Color3.fromRGB(0, 200, 255)
    end
end

-- Real-time Key Input Verification (Triggers instantly without Enter key requirement)
keyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local cleanInput = keyInput.Text:gsub("%s+", ""):gsub("%c+", "")
    if cleanInput == secretKey then
        keyFrame:Destroy()
        borderStroke.Color = Color3.fromRGB(0, 200, 255)
        titleLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if keyFrame.Parent ~= nil then return end
    
    if input.KeyCode == Enum.KeyCode.M then
        farmActive = not farmActive
        updateUIStatus()
    end
end)

-- Main Automation Processing Unit Thread
task.spawn(function()
    local processedCores = {}
    
    while true do
        task.wait(0.01)
        
        if farmActive and keyFrame.Parent == nil then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                local foundList = getTargets("Core")
                
                local filteredList = {}
                for _, target in ipairs(foundList) do
                    if not processedCores[target] then
                        table.insert(filteredList, target)
                    end
                end
                
                if #filteredList == 0 then
                    processedCores = {}
                    filteredList = foundList
                end
                
                local activeCore = getClosestTarget(filteredList, hrp)
                
                if activeCore then
                    processedCores[activeCore] = true
                    
                    local prompt = activeCore:FindFirstChildOfClass("ProximityPrompt")
                    if not prompt then
                        for _, child in pairs(activeCore:GetChildren()) do
                            if child:IsA("ProximityPrompt") then 
                                prompt = child 
                                break 
                            end
                        end
                    end
                    
                    local elapsed = 0
                    while elapsed < farmDelay and farmActive and activeCore and activeCore.Parent and hrp.Parent do
                        hrp.CFrame = activeCore.CFrame * CFrame.new(0, 0, 3)
                        hrp.Velocity = Vector3.new(0, 0, 0)
                        if prompt then
                            task.spawn(function()
                                triggerPrompt(prompt)
                            end)
                        end
                        task.wait(0.02)
                        elapsed = elapsed + 0.02
                    end
                end
            end
        end
    end
end)
