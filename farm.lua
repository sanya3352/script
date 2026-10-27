-- Delta Executor Elite Auto-Farm UI (v14 - Key System Protected)
-- Secret Access Key: ASTRO-X99F-72QL-ZBM7-K3W1

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local secretKey = "ASTRO-X99F-72QL-ZBM7-K3W1" -- Hardcoded Secure Key
local farmActive = false
local farmDelay = 0.8
local coresFarmed = 0

local parentGui = player:WaitForChild("PlayerGui")
if parentGui:FindFirstChild("EliteCoreFarmUI") then
    parentGui["EliteCoreFarmUI"]:Destroy()
end

-- Anti-AFK Method
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end)

-- Main GUI Frame
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EliteCoreFarmUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = parentGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 240)
mainFrame.Position = UDim2.new(0.05, 0, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(255, 40, 80) -- Red for Locked State
borderStroke.Thickness = 1.5
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
titleLabel.Text = "   ASTRONAUT CHEATS [v14]"
titleLabel.TextColor3 = Color3.fromRGB(255, 50, 100)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleLabel

-- =======================================================
-- KEY SYSTEM INTERFACE LAYER (BLOCKED UNTIL VALIDATED)
-- =======================================================
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(1, 0, 1, -40)
keyFrame.Position = UDim2.new(0, 0, 0, 40)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
keyFrame.BorderSizePixel = 0
keyFrame.ZIndex = 5
keyFrame.Parent = mainFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keyFrame

local keyNotice = Instance.new("TextLabel")
keyNotice.Size = UDim2.new(1, -30, 0, 40)
keyNotice.Position = UDim2.new(0, 15, 0, 20)
keyNotice.BackgroundTransparency = 1
keyNotice.Text = "ENTER SECURITY LICENSE KEY:"
keyNotice.TextColor3 = Color3.fromRGB(200, 200, 210)
keyNotice.Font = Enum.Font.GothamBold
keyNotice.TextSize = 12
keyNotice.ZIndex = 5
keyNotice.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -40, 0, 35)
keyInput.Position = UDim2.new(0, 20, 0, 65)
keyInput.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
keyInput.Text = ""
keyInput.PlaceholderText = "Paste License Key Here..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 11
keyInput.ZIndex = 5
keyInput.Parent = keyFrame

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 6)
keyInputCorner.Parent = keyInput

local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(1, -40, 0, 40)
checkButton.Position = UDim2.new(0, 20, 0, 115)
checkButton.BackgroundColor3 = Color3.fromRGB(255, 40, 80)
checkButton.Text = "VALIDATE SYSTEM ACCESS"
checkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkButton.Font = Enum.Font.GothamBold
checkButton.TextSize = 12
checkButton.ZIndex = 5
checkButton.Parent = keyFrame

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 6)
checkCorner.Parent = checkButton

-- =======================================================
-- MAIN AUTO-FARM INTERFACE ELEMENTS (HIDDEN UNDER KEY)
-- =======================================================
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 25)
statusLabel.Position = UDim2.new(0, 15, 0, 50)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "SYSTEM: IDLE"
statusLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextSize = 12
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

local statsLabel = Instance.new("TextLabel")
statsLabel.Size = UDim2.new(1, -30, 0, 25)
statsLabel.Position = UDim2.new(0, 15, 0, 75)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "CORES COLLECTED: 0"
statsLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
statsLabel.Font = Enum.Font.GothamSemibold
statsLabel.TextSize = 12
statsLabel.TextXAlignment = Enum.TextXAlignment.Left
statsLabel.Parent = mainFrame

local delayLabel = Instance.new("TextLabel")
delayLabel.Size = UDim2.new(0, 130, 0, 30)
delayLabel.Position = UDim2.new(0, 15, 0, 110)
delayLabel.BackgroundTransparency = 1
delayLabel.Text = "TELEPORT INTERVAL:"
delayLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
delayLabel.Font = Enum.Font.GothamBold
delayLabel.TextSize = 11
delayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayLabel.Parent = mainFrame

local delayInput = Instance.new("TextBox")
delayInput.Size = UDim2.new(0, 70, 0, 30)
delayInput.Position = UDim2.new(0, 195, 0, 110)
delayInput.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
delayInput.Text = "0.8"
delayInput.TextColor3 = Color3.fromRGB(255, 255, 255)
delayInput.Font = Enum.Font.GothamBold
delayInput.TextSize = 12
delayInput.ClearTextOnFocus = false
delayInput.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = delayInput

local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(50, 50, 60)
inputStroke.Thickness = 1
inputStroke.Parent = delayInput

delayInput.FocusLost:Connect(function()
    local num = tonumber(delayInput.Text)
    if num and num >= 0 then
        farmDelay = num
    else
        delayInput.Text = tostring(farmDelay)
    end
end)

local hotkeyLabel = Instance.new("TextLabel")
hotkeyLabel.Size = UDim2.new(1, 0, 0, 20)
hotkeyLabel.Position = UDim2.new(0, 0, 0, 150)
hotkeyLabel.BackgroundTransparency = 1
hotkeyLabel.Text = "[Press 'M' Key to Toggle Instantly]"
hotkeyLabel.TextColor3 = Color3.fromRGB(100, 100, 110)
hotkeyLabel.Font = Enum.Font.Gotham
hotkeyLabel.TextSize = 11
hotkeyLabel.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, -30, 0, 45)
toggleButton.Position = UDim2.new(0, 15, 0, 180)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 40, 70)
toggleButton.Text = "EXECUTE FARM [OFF]"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 13
toggleButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleButton

-- Core Farming Logic Helpers
local function getAllCoresByName()
    local cores = {}
    local workspaceChildren = game:GetService("Workspace"):GetDescendants()
    for _, obj in ipairs(workspaceChildren) do
        if obj:IsA("BasePart") and obj.Name == "Core" then
            table.insert(cores, obj)
        end
    end
    return cores
end

local function getClosestCore(coreList, hrp)
    local closestCore = nil
    local shortestDistance = math.huge
    for _, core in ipairs(coreList) do
        if core and core.Parent and hrp then
            local distance = (hrp.Position - core.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestCore = core
            end
        end
    end
    return closestCore
end

local function triggerPrompt(prompt)
    if fireproximityprompt then
        fireproximityprompt(prompt)
    else
        task.spawn(function()
            prompt:InputBegan(Enum.UserInputType.Keyboard)
            task.wait(farmDelay * 0.9)
            prompt:InputEnded(Enum.UserInputType.Keyboard)
        end)
    end
end

local function updateUI()
    if farmActive then
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
        toggleButton.Text = "EXECUTE FARM [ACTIVE]"
        borderStroke.Color = Color3.fromRGB(0, 255, 150)
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 40, 70)
        toggleButton.Text = "EXECUTE FARM [OFF]"
        borderStroke.Color = Color3.fromRGB(0, 200, 255)
        statusLabel.Text = "SYSTEM: IDLE"
    end
end

local function toggleFarmProcess()
    if keyFrame.Parent ~= nil then return end -- Block actions if still locked
    farmActive = not farmActive
    updateUI()
end

-- Key Authentication Verification Action
checkButton.MouseButton1Click:Connect(function()
    if keyInput.Text == secretKey then
        keyFrame:Destroy() -- Removes key layer permanently for session
        borderStroke.Color = Color3.fromRGB(0, 200, 255) -- Cyan for active system
        titleLabel.TextColor3 = Color3.fromRGB(0, 210, 255)
    else
        keyNotice.Text = "INVALID LICENSE CODE! TRY AGAIN"
        keyNotice.TextColor3 = Color3.fromRGB(255, 0, 50)
        task.wait(1.5)
        keyNotice.Text = "ENTER SECURITY LICENSE KEY:"
        keyNotice.TextColor3 = Color3.fromRGB(200, 200, 210)
    end
end)

toggleButton.MouseButton1Click:Connect(toggleFarmProcess)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        toggleFarmProcess()
    end
end)

-- Main Farm Core Thread Execution
task.spawn(function()
    local checkedCores = {}
    while true do
        task.wait(0.1)
        if farmActive and keyFrame.Parent == nil then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                statusLabel.Text = "SYSTEM: SCANNING WORKSPACE..."
                local coreList = getAllCoresByName()
                local availableCores = {}
                for _, c in ipairs(coreList) do
                    if not checkedCores[c] then
                        table.insert(availableCores, c)
                    end
                end
                if #availableCores == 0 then
                    checkedCores = {}
                    availableCores = coreList
                end
                local targetCore = getClosestCore(availableCores, hrp)
                if targetCore then
                    statusLabel.Text = "SYSTEM: TELEPORTING TO CLOSEST..."
                    checkedCores[targetCore] = true
                    local prompt = targetCore:FindFirstChildOfClass("ProximityPrompt")
                    if not prompt then
                        for _, child in pairs(targetCore:GetChildren()) do
                            if child:IsA("ProximityPrompt") then
                                prompt = child
                                break
                            end
                        end
                    end
                    local teleportTime = 0
                    local trackingIncremented = false
                    while teleportTime < farmDelay and farmActive and targetCore and targetCore.Parent and hrp.Parent do
                        hrp.CFrame = targetCore.CFrame * CFrame.new(0, 0, 3)
                        hrp.Velocity = Vector3.new(0, 0, 0)
                        if prompt then
                            triggerPrompt(prompt)
                            if not trackingIncremented then
                                coresFarmed = coresFarmed + 1
                                statsLabel.Text = "CORES COLLECTED: " .. tostring(coresFarmed)
                                trackingIncremented = true
                            end
                        end
                        task.wait(0.1)
                        teleportTime = teleportTime + 0.1
                    end
                else
                    statusLabel.Text = "SYSTEM: CORES NOT DETECTED"
                    task.wait(1)
                end
            else
                statusLabel.Text = "SYSTEM: WAITING FOR CHARACTER"
                task.wait(1)
            end
        end
    end
end)
