if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
    repeat wait()
        if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
            if _G.Team == "Pirate" then
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                    v.Function()
                end
            elseif _G.Team == "Marine" then
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                    v.Function()
                end
            else
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                    v.Function()
                end
            end
        end
    until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Devil Shop Menu"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Parent = mainFrame

local playerName = Instance.new("TextLabel")
playerName.Size = UDim2.new(0.5, 0, 0, 30)
playerName.Position = UDim2.new(0, 70, 0.2, 0)
playerName.BackgroundTransparency = 1
playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
playerName.Font = Enum.Font.GothamBold
playerName.TextSize = 16
playerName.Text = game.Players.LocalPlayer.Name
playerName.Parent = mainFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 50, 0, 50)
avatarImage.Position = UDim2.new(0, 10, 0.2, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. game.Players.LocalPlayer.UserId .. "&w=150&h=150"
avatarImage.Parent = mainFrame

local buyFruitToggle = Instance.new("TextButton")
buyFruitToggle.Size = UDim2.new(0.9, 0, 0, 40)
buyFruitToggle.Position = UDim2.new(0.05, 0, 0.4, 0)
buyFruitToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
buyFruitToggle.Text = "Auto Buy Fruit: Off"
buyFruitToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
buyFruitToggle.Font = Enum.Font.GothamBold
buyFruitToggle.TextSize = 14
buyFruitToggle.Parent = mainFrame

local storeFruitToggle = Instance.new("TextButton")
storeFruitToggle.Size = UDim2.new(0.9, 0, 0, 40)
storeFruitToggle.Position = UDim2.new(0.05, 0, 0.6, 0)
storeFruitToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
storeFruitToggle.Text = "Auto Store Fruit: Off"
storeFruitToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
storeFruitToggle.Font = Enum.Font.GothamBold
storeFruitToggle.TextSize = 14
storeFruitToggle.Parent = mainFrame

local teleportFruitToggle = Instance.new("TextButton")
teleportFruitToggle.Size = UDim2.new(0.9, 0, 0, 40)
teleportFruitToggle.Position = UDim2.new(0.05, 0, 0.8, 0)
teleportFruitToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
teleportFruitToggle.Text = "Teleport to Fruit: Off"
teleportFruitToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportFruitToggle.Font = Enum.Font.GothamBold
teleportFruitToggle.TextSize = 14
teleportFruitToggle.Parent = mainFrame

local AutoBuyFruitZioles = false
local AutoStoreFruit = false
_G.TeleportFruit = false

local dragging, dragInput, dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

buyFruitToggle.MouseButton1Click:Connect(function()
    AutoBuyFruitZioles = not AutoBuyFruitZioles
    if AutoBuyFruitZioles then
        buyFruitToggle.Text = "Auto Buy Fruit: On"
        buyFruitToggle.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
    else
        buyFruitToggle.Text = "Auto Buy Fruit: Off"
        buyFruitToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    end
end)

spawn(function()
    while wait() do
        if AutoBuyFruitZioles then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end)
        end
    end
end)

storeFruitToggle.MouseButton1Click:Connect(function()
    AutoStoreFruit = not AutoStoreFruit
    if AutoStoreFruit then
        storeFruitToggle.Text = "Auto Store Fruit: On"
        storeFruitToggle.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
    else
        storeFruitToggle.Text = "Auto Store Fruit: Off"
        storeFruitToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    end
end)

spawn(function()
    while wait() do
        if AutoStoreFruit then
            pcall(function()
                StoredFruited("Rocket-Rocket", "Rocket Fruit")
                StoredFruited("Spin-Spin", "Spin Fruit")
                StoredFruited("Chop-Chop", "Chop Fruit")
                StoredFruited("Spring-Spring", "Spring Fruit")
                StoredFruited("Bomb-Bomb", "Bomb Fruit")
                StoredFruited("Smoke-Smoke", "Smoke Fruit")
                StoredFruited("Spike-Spike", "Spike Fruit")
                StoredFruited("Flame-Flame", "Flame Fruit")
                StoredFruited("Falcon-Falcon", "Falcon Fruit")
                StoredFruited("Ice-Ice", "Ice Fruit")
                StoredFruited("Sand-Sand", "Sand Fruit")
                StoredFruited("Dark-Dark", "Dark Fruit")
                StoredFruited("Diamond-Diamond", "Diamond Fruit")
                StoredFruited("Light-Light", "Light Fruit")
                StoredFruited("Rubber-Rubber", "Rubber Fruit")
                StoredFruited("Barrier-Barrier", "Barrier Fruit")
                StoredFruited("Ghost-Ghost", "Ghost Fruit")
                StoredFruited("Magma-Magma", "Magma Fruit")
                StoredFruited("Quake-Quake", "Quake Fruit")
                StoredFruited("Buddha-Buddha", "Buddha Fruit")
                StoredFruited("Love-Love", "Love Fruit")
                StoredFruited("Spider-Spider", "Spider Fruit")
                StoredFruited("Sound-Sound", "Sound Fruit")
                StoredFruited("Phoenix-Phoenix", "Phoenix Fruit")
                StoredFruited("Portal-Portal", "Portal Fruit")
                StoredFruited("Rumble-Rumble", "Rumble Fruit")
                StoredFruited("Pain-Pain", "Pain Fruit")
                StoredFruited("Blizzard-Blizzard", "Blizzard Fruit")
                StoredFruited("Gravity-Gravity", "Gravity Fruit")
                StoredFruited("Mammoth-Mammoth", "Mammoth Fruit")
                StoredFruited("Dough-Dough", "Dough Fruit")
                StoredFruited("Shadow-Shadow", "Shadow Fruit")
                StoredFruited("Venom-Venom", "Venom Fruit")
                StoredFruited("Control-Control", "Control Fruit")
                StoredFruited("Spirit-Spirit", "Spirit Fruit")
                StoredFruited("Dragon-Dragon", "Dragon Fruit")
                StoredFruited("Leopard-Leopard", "Leopard Fruit")
                StoredFruited("Kitsune-Kitsune", "Kitsune Fruit")
            end)
        end
    end
end)

teleportFruitToggle.MouseButton1Click:Connect(function()
    _G.TeleportFruit = not _G.TeleportFruit
    if _G.TeleportFruit then
        teleportFruitToggle.Text = "Teleport to Fruit: On"
        teleportFruitToggle.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
    else
        teleportFruitToggle.Text = "Teleport to Fruit: Off"
        teleportFruitToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    end
end)

spawn(function()
    while wait() do
        if _G.TeleportFruit then
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                end
            end
        end
    end
end)

function StoredFruited(name_1, name_2)
    local Character = game.Players.LocalPlayer.Character
    local Backpack = game.Players.LocalPlayer.Backpack
    local CommF_ = game:GetService("ReplicatedStorage").Remotes.CommF_
    if Character:FindFirstChild(name_2) or Backpack:FindFirstChild(name_2) then
        local args = {
            [1] = "StoreFruit",
            [2] = name_1,
            [3] = Character:FindFirstChild(name_2) or Backpack:FindFirstChild(name_2)
        }
        CommF_:InvokeServer(unpack(args))
    end
end

function getNil(name,class)
    for _,v in next, getnilinstances() do
        if v.ClassName == class and v.Name == name then
            return v
        end
    end
end
