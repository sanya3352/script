-- Delta Executor Ultimate Auto-Farm (v15 - NPC Farm Edition)
-- Access License Key: farmedit

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local secretKey = "farmedit"
local farmActive = false
local farmDelay = 1.0 -- Enforced 1 second target transition delay
local currentMode = "Cores" -- Toggle modes: Cores or NPCs

local parentGui = player:WaitForChild("PlayerGui")
if parentGui:FindFirstChild("EliteCoreFarmUI") then
    parentGui["EliteCoreFarmUI"]:Destroy()
end

-- Anti-AFK Method
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end)

-- Premium UI Design
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EliteCoreFarmUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = parentGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 270)
mainFrame.Position = UDim2.new(0.05, 0, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(255, 165, 0) -- Amber Locked State
borderStroke.Thickness = 2
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
titleLabel.Text = "   ASTRONAUT ENGINE [v15]"
titleLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleLabel

-- =======================================================
-- ACCESS LOCK SYSTEM GUI
-- =======================================================
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(1, 0, 1, -45)
keyFrame.Position = UDim2.new(0, 0, 0, 45)
keyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
keyFrame.BorderSizePixel = 0
keyFrame.ZIndex = 5
keyFrame.Parent = mainFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 14)
keyCorner.Parent = keyFrame

local keyNotice = Instance.new("TextLabel")
keyNotice.Size = UDim2.new(1, -30, 0, 40)
keyNotice.Position = UDim2.new(0, 15, 0, 30)
keyNotice.BackgroundTransparency = 1
keyNotice.Text = "ENTER SECURITY LICENSE KEY:"
keyNotice.TextColor3 = Color3.fromRGB(180, 180, 190)
keyNotice.Font = Enum.Font.GothamBold
keyNotice.TextSize = 12
keyNotice.ZIndex = 5
keyNotice.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -40, 0, 35)
keyInput.Position = UDim2.new(0, 20, 0, 80)
keyInput.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
keyInput.Text = ""
keyInput.PlaceholderText = "Enter key here..."
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 12
keyInput.ZIndex = 5
keyInput.Parent = keyFrame

local keyInputCorner = Instance.new("UICorner")
keyInputCorner.CornerRadius = UDim.new(0, 6)
keyInputCorner.Parent = keyInput

local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(1, -40, 0, 40)
checkButton.Position = UDim2.new(0, 20, 0, 140)
checkButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
checkButton.Text = "AUTHORIZE SYSTEM"
checkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkButton.Font = Enum.Font.GothamBold
checkButton.TextSize = 12
checkButton.ZIndex = 5
checkButton.Parent = keyFrame

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 6)
checkCorner.Parent = checkButton

-- =======================================================
-- ACTIVE FARMING INTERFACE SYSTEM
-- =======================================================
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 25)
statusLabel.Position = UDim2.new(0, 15, 0, 55)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "STATUS: SECURITY LOCKED"
statusLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextSize = 12
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

-- Mode Selection Button
local modeButton = Instance.new("TextButton")
modeButton.Size = UDim2.new(1, -30, 0, 35)
modeButton.Position = UDim2.new(0, 15, 0, 90)
modeButton.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
modeButton.Text = "TARGET MODE: CORES"
modeButton.TextColor3 = Color3.fromRGB(0, 210, 255)
modeButton.Font = Enum.Font.GothamBold
modeButton.TextSize = 12
modeButton.Parent = mainFrame

local modeCorner = Instance.new("UICorner")
modeCorner.CornerRadius = UDim.new(0, 8)
modeCorner.Parent = modeButton

local hotkeyLabel = Instance.new("TextLabel")
hotkeyLabel.Size = UDim2.new(1, 0, 0, 20)
hotkeyLabel.Position = UDim2.new(0, 0, 0, 140)
hotkeyLabel.BackgroundTransparency = 1
hotkeyLabel.Text = "[Press 'M' Key to Toggle Instantly]"
hotkeyLabel.TextColor3 = Color3.fromRGB(110, 110, 120)
hotkeyLabel.Font = Enum.Font.GothamMed
hotkeyLabel.TextSize = 11
hotkeyLabel.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, -30, 0, 45)
toggleButton.Position = UDim2.new(0, 15, 0, 175)
toggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 80)
toggleButton.Text = "START AUTOMATION [OFF]"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 13
toggleButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleButton

-- Global Target Core and Head Finders
local function getTargets(name)
    local targets = {}
    local workspaceChildren = Workspace:GetDescendants()
    for _, obj in ipairs(workspaceChildren) do
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

-- Weapon Click Execution Simulation
local function performWeaponShot()
    VirtualUser:Button1Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    task.wait(0.05)
    VirtualUser:Button1Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end

local function triggerPrompt(prompt)
    if fireproximityprompt then
        fireproximityprompt(prompt)
    else
        task.spawn(function()
            prompt:InputBegan(Enum.UserInputType.Keyboard)
            task.wait(0.5)
            prompt:InputEnded(Enum.UserInputType.Keyboard)
        end)
    end
end

-- UI State Management Engine
local function updateUI()
    if farmActive then
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
        toggleButton.Text = "AUTOMATION RUNNING [ACTIVE]"
        borderStroke.Color = Color3.fromRGB(0, 255, 120)
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 80)
        toggleButton.Text = "START AUTOMATION [OFF]"
        borderStroke.Color = Color3.fromRGB(0, 200, 255)
        statusLabel.Text = "STATUS: IDLE"
    end
end

local function toggleFarm()
    if keyFrame.Parent ~= nil then return end
    farmActive = not farmActive
    updateUI()
end

-- Mode Controller Logic
modeButton.MouseButton1Click:Connect(function()
    if keyFrame.Parent ~= nil then return end
    if currentMode == "Cores" then
        currentMode = "NPCs"
        modeButton.Text = "TARGET MODE: NPCs (HEADS)"
        modeButton.TextColor3 = Color3.fromRGB(255, 140, 0)
    else
        currentMode = "Cores"
        modeButton.Text = "TARGET MODE: CORES"
        modeButton.TextColor3 = Color3.fromRGB(0, 210, 255)
    end
end)

-- Validation Event Action Trigger
checkButton.MouseButton1Click:Connect(function()
    if keyInput.Text == secretKey then
        keyFrame:Destroy()
        borderStroke.Color = Color3.fromRGB(0, 200, 255) -- Cyan Authorized State
        titleLabel.TextColor3 = Color3.fromRGB(0, 210, 255)
        statusLabel.Text = "STATUS: IDLE"
    else
        keyNotice.Text = "ACCESS DENIED! WRONG SYSTEM LICENSE"
        keyNotice.TextColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(1.5)
        keyNotice.Text = "ENTER SECURITY LICENSE KEY:"
        keyNotice.TextColor3 = Color3.fromRGB(180, 180, 190)
    end
end)

toggleButton.MouseButton1Click:Connect(toggleFarm)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        toggleFarm()
    end
end)

-- Advanced Multi-Mode Core Loop Engine
task.spawn(function()
    local processedTargets = {}
    
    while true do
        task.wait(0.05)
        
        if farmActive and keyFrame.Parent == nil then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local camera = Workspace.CurrentCamera
            
            if hrp then
                local currentSearchName = (currentMode == "Cores") and "Core" or "Head"
                local foundList = getTargets(currentSearchName)
                
                local filteredList = {}
                for _, target in ipairs(foundList) do
                    if not processedTargets[target] then
                        table.insert(filteredList, target)
                    end
                end
                
                if #filteredList == 0 then
                    processedTargets = {}
                    filteredList = foundList
                end
                
                local activeTarget = getClosestTarget(filteredList, hrp)
                
                if activeTarget then
                    processedTargets[activeTarget] = true
                    
                    if currentMode == "Cores" then
                        -- Cores Method: Standard Teleport Interaction
                        statusLabel.Text = "TARGET: FARMING NEAREST CORE"
                        local prompt = activeTarget:FindFirstChildOfClass("ProximityPrompt")
                        if not prompt then
                            for _, child in pairs(activeTarget:GetChildren()) do
                                if child:IsA("ProximityPrompt") then prompt = child break end
                            end
                        end
                        
                        local elapsed = 0
                        while elapsed < 0.8 and farmActive and activeTarget and activeTarget.Parent and hrp.Parent do
                            hrp.CFrame = activeTarget.CFrame * CFrame.new(0, 0, 3)
                            hrp.Velocity = Vector3.new(0, 0, 0)
                            if prompt then triggerPrompt(prompt) end
                            task.wait(0.1)
                            elapsed = elapsed + 0.1
                        end
                    else
                        -- NPCs Combat Method: 8 Studs Offset Combat + Aimbot Focus + Instant Action
                        statusLabel.Text = "TARGET: ATTACKING NPC HEAD"
                        if activeTarget and activeTarget.Parent and hrp.Parent then
                            -- Teleport character securely 8 studs offset horizontally away from target head
                            hrp.CFrame = activeTarget.CFrame * CFrame.new(0, 0, 8)
                            hrp.Velocity = Vector3.new(0, 0, 0)
                            task.wait(0.1)
                            
                            -- Force Aimbot Camera lock onto target head
                            camera.CFrame = CFrame.new(camera.CFrame.Position, activeTarget.Position)
                            task.wait(0.05)
                            
                            -- Process shot interaction execution
                            performWeaponShot()
                            
                            -- 1 second safety transition delay buffer sequence
                            statusLabel.Text = "TARGET: CYCLE DELAY RECOVERY..."
                            task.wait(1.0)
                        end
                    end
                else
                    statusLabel.Text = "STATUS: NO OBJECTS DETECTED"
                    task.wait(1)
                end
            else
                statusLabel.Text = "STATUS: CHAR NOT DETECTED"
                task.wait(1)
            end
        end
    end
end)
