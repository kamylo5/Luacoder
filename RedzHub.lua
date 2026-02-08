-- RedzHub v4.0 - Mobile Edition
-- Interface otimizada para celular/touch

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

-- Detectar se está em celular
local IS_MOBILE = UserInputService.TouchEnabled
local IS_TABLET = GuiService:GetScreenResolution().Y < 900

print("📱 RedzHub Mobile v4.0 iniciando...")
print("📟 Plataforma: " .. (IS_MOBILE and "Celular" or "PC"))
print("👤 Player: " .. Player.Name)

-- Variáveis globais
_G.Settings = {
    AutoFarm = false,
    AutoClick = false,
    SpeedHack = false,
    JumpHack = false,
    NoClip = false,
    AntiAFK = true,
    WalkSpeed = 80,
    JumpPower = 80,
    FarmDistance = 30,
    BossSelected = "Saber Expert"
}

-- ============================================
-- FUNÇÕES AUXILIARES PARA CELULAR
-- ============================================
local function CreateElement(elementType, properties)
    local element = Instance.new(elementType)
    for property, value in pairs(properties) do
        if property == "Parent" then
            element.Parent = value
        else
            element[property] = value
        end
    end
    return element
end

-- Função para criar botões grandes (touch friendly)
local function CreateMobileButton(parent, text, callback, position, size)
    local button = CreateElement("TextButton", {
        Text = text,
        Size = size or UDim2.new(0.45, 0, 0, IS_MOBILE and 60 or 50),
        Position = position,
        BackgroundColor3 = Color3.fromRGB(60, 50, 120),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamSemibold,
        TextSize = IS_MOBILE and 18 or 16,
        TextScaled = IS_MOBILE,
        Parent = parent
    })
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 80, 180)
    stroke.Thickness = 2
    stroke.Parent = button
    
    -- Efeito de toque
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(80, 70, 150),
            Size = (size or UDim2.new(0.45, 0, 0, IS_MOBILE and 60 or 50)) + UDim2.new(0, -5, 0, -5)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(60, 50, 120),
            Size = size or UDim2.new(0.45, 0, 0, IS_MOBILE and 60 or 50)
        }):Play()
        callback()
    end)
    
    button.MouseEnter:Connect(function()
        if not IS_MOBILE then
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(80, 70, 150)
            }):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not IS_MOBILE then
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 50, 120)
            }):Play()
        end
    end)
    
    return button
end

-- ============================================
-- INTERFACE PRINCIPAL PARA CELULAR
-- ============================================
local ScreenGui = CreateElement("ScreenGui", {
    Name = "RedzHubMobile",
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = game.CoreGui
})

-- Botão flutuante para abrir menu (apenas mobile)
local FloatingButton
if IS_MOBILE then
    FloatingButton = CreateElement("TextButton", {
        Name = "FloatingButton",
        Text = "🎮",
        Size = UDim2.new(0, 70, 0, 70),
        Position = UDim2.new(1, -80, 0.8, 0),
        BackgroundColor3 = Color3.fromRGB(120, 80, 200),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 30,
        Parent = ScreenGui
    })
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = FloatingButton
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.BackgroundTransparency = 1
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.Parent = FloatingButton
end

-- Janela principal (maior para celular)
local MainWindow = CreateElement("Frame", {
    Name = "MainWindow",
    Size = IS_MOBILE and UDim2.new(0.95, 0, 0.85, 0) or UDim2.new(0, 500, 0, 600),
    Position = IS_MOBILE and UDim2.new(0.025, 0, 0.075, 0) or UDim2.new(0.5, -250, 0.5, -300),
    BackgroundColor3 = Color3.fromRGB(20, 15, 30),
    Parent = ScreenGui
})

if IS_MOBILE then
    MainWindow.Visible = false -- Escondido até clicar no botão flutuante
end

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = MainWindow

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 70, 200)
stroke.Thickness = 3
stroke.Parent = MainWindow

-- ============================================
-- CABEÇALHO MOBILE
-- ============================================
local Header = CreateElement("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, IS_MOBILE and 80 or 60),
    BackgroundColor3 = Color3.fromRGB(30, 25, 45),
    Parent = MainWindow
})

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 20)
headerCorner.Parent = Header

local Title = CreateElement("TextLabel", {
    Name = "Title",
    Text = "📱 REDZHUB v4.0",
    Size = UDim2.new(1, -100, 1, 0),
    Position = UDim2.new(0, 20, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = IS_MOBILE and 26 or 24,
    TextScaled = IS_MOBILE,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header
})

local Subtitle = CreateElement("TextLabel", {
    Name = "Subtitle",
    Text = IS_MOBILE and "Toque nos botões para ativar" or "Clique nos botões para ativar",
    Size = UDim2.new(1, -100, 0, 30),
    Position = UDim2.new(0, 20, 0, IS_MOBILE and 40 or 30),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(180, 180, 220),
    Font = Enum.Font.Gotham,
    TextSize = IS_MOBILE and 14 or 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header
})

local CloseButton = CreateElement("TextButton", {
    Name = "CloseButton",
    Text = IS_MOBILE and "✕" : "X",
    Size = UDim2.new(0, IS_MOBILE and 70 or 50, 0, IS_MOBILE and 70 or 50),
    Position = UDim2.new(1, IS_MOBILE and -75 : -55, 0.5, IS_MOBILE and -35 : -25),
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = IS_MOBILE and 30 : 24,
    Parent = Header
})

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(IS_MOBILE and 0.5 or 0, IS_MOBILE and 0 : 8)
closeCorner.Parent = CloseButton

-- ============================================
-- ÁREA DE CONTEÚDO SCROLLABLE
-- ============================================
local ScrollFrame = CreateElement("ScrollingFrame", {
    Name = "ScrollFrame",
    Size = UDim2.new(1, 0, 1, IS_MOBILE and -90 : -70),
    Position = UDim2.new(0, 0, 0, IS_MOBILE and 85 : 65),
    BackgroundTransparency = 1,
    ScrollBarThickness = IS_MOBILE and 10 : 8,
    ScrollBarImageColor3 = Color3.fromRGB(100, 70, 200),
    CanvasSize = UDim2.new(0, 0, 0, IS_MOBILE and 1200 : 800),
    Parent = MainWindow
})

-- ============================================
-- SEÇÕES PRINCIPAIS (VERTICAL PARA CELULAR)
-- ============================================
local function CreateMobileSection(title, yPosition)
    local section = CreateElement("Frame", {
        Name = title .. "Section",
        Size = UDim2.new(0.95, 0, 0, IS_MOBILE and 180 : 150),
        Position = UDim2.new(0.025, 0, 0, yPosition),
        BackgroundColor3 = Color3.fromRGB(35, 30, 50),
        Parent = ScrollFrame
    })
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 15)
    sectionCorner.Parent = section
    
    local sectionTitle = CreateElement("TextLabel", {
        Text = "📌 " .. title,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(200, 180, 255),
        Font = Enum.Font.GothamBold,
        TextSize = IS_MOBILE and 20 : 18,
        TextScaled = IS_MOBILE,
        Parent = section
    })
    
    return section
end

-- ============================================
-- FUNÇÕES PRINCIPAIS
-- ============================================
local function ToggleFunction(name)
    _G.Settings[name] = not _G.Settings[name]
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = name,
        Text = _G.Settings[name] and "✅ ATIVADO" : "❌ DESATIVADO",
        Duration = 2
    })
    
    print(name .. ": " .. (_G.Settings[name] and "ON" : "OFF"))
end

local function TeleportTo(position)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "📍 Teleport",
            Text = "Teleportado com sucesso!",
            Duration = 3
        })
    end
end

-- ============================================
-- SEÇÃO 1: AUTO FARM
-- ============================================
local farmSection = CreateMobileSection("AUTO FARM", 20)

CreateMobileButton(farmSection, "⚔️ AUTO FARM", function()
    ToggleFunction("AutoFarm")
end, UDim2.new(0.025, 0, 0.3, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

CreateMobileButton(farmSection, "🎯 AUTO CLICK", function()
    ToggleFunction("AutoClick")
end, UDim2.new(0.525, 0, 0.3, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

CreateMobileButton(farmSection, "📦 COLETAR DROPS", function()
    ToggleFunction("AutoCollect")
end, UDim2.new(0.025, 0, 0.7, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

CreateMobileButton(farmSection, "👑 BOSS FARM", function()
    ToggleFunction("BossFarm")
end, UDim2.new(0.525, 0, 0.7, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

-- ============================================
-- SEÇÃO 2: PLAYER MODS
-- ============================================
local playerSection = CreateMobileSection("PLAYER MODS", 220)

CreateMobileButton(playerSection, "🚀 SPEED HACK", function()
    ToggleFunction("SpeedHack")
    if _G.Settings.SpeedHack and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = _G.Settings.WalkSpeed
    end
end, UDim2.new(0.025, 0, 0.3, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

CreateMobileButton(playerSection, "🌙 JUMP HACK", function()
    ToggleFunction("JumpHack")
end, UDim2.new(0.525, 0, 0.3, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

CreateMobileButton(playerSection, "👻 NO CLIP", function()
    ToggleFunction("NoClip")
end, UDim2.new(0.025, 0, 0.7, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

CreateMobileButton(playerSection, "⏰ ANTI-AFK", function()
    ToggleFunction("AntiAFK")
end, UDim2.new(0.525, 0, 0.7, 0), UDim2.new(0.45, 0, 0, IS_MOBILE and 70 : 60))

-- ============================================
-- SEÇÃO 3: TELEPORT
-- ============================================
local teleportSection = CreateMobileSection("TELEPORT", 420)

local locations = {
    {"🏝️ STARTER", Vector3.new(1072, 16, 1431)},
    {"🌴 JUNGLE", Vector3.new(-1612, 37, 149)},
    {"🏴‍☠️ PIRATES", Vector3.new(-1181, 5, 3803)},
    {"🏜️ DESERT", Vector3.new(1094, 6, 4195)}
}

for i, loc in ipairs(locations) do
    local yPos = 0.2 + (i * 0.15)
    CreateMobileButton(teleportSection, loc[1], function()
        TeleportTo(loc[2])
    end, UDim2.new(0.025, 0, yPos, 0), UDim2.new(0.95, 0, 0, IS_MOBILE and 60 : 50))
end

-- ============================================
-- SEÇÃO 4: UTILIDADES
-- ============================================
local utilsSection = CreateMobileSection("UTILIDADES", 680)

CreateMobileButton(utilsSection, "🔄 REJOIN", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end, UDim2.new(0.025, 0, 0.2, 0), UDim2.new(0.95, 0, 0, IS_MOBILE and 60 : 50))

CreateMobileButton(utilsSection, "📋 COPY DISCORD", function()
    setclipboard("discord.gg/redzhub")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Discord",
        Text = "Link copiado!",
        Duration = 3
    })
end, UDim2.new(0.025, 0, 0.45, 0), UDim2.new(0.95, 0, 0, IS_MOBILE and 60 : 50))

CreateMobileButton(utilsSection, "⚙️ SETTINGS", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Configurações",
        Text = "Em breve mais opções!",
        Duration = 3
    })
end, UDim2.new(0.025, 0, 0.7, 0), UDim2.new(0.95, 0, 0, IS_MOBILE and 60 : 50))

-- ============================================
-- RODAPÉ
-- ============================================
local Footer = CreateElement("Frame", {
    Name = "Footer",
    Size = UDim2.new(1, 0, 0, IS_MOBILE and 50 : 40),
    Position = UDim2.new(0, 0, 1, IS_MOBILE and -55 : -45),
    BackgroundColor3 = Color3.fromRGB(25, 20, 40),
    Parent = MainWindow
})

local Status = CreateElement("TextLabel", {
    Text = IS_MOBILE and "📱 RedzHub Mobile • Toque para ativar" : "🎮 RedzHub v4.0 • Pressione F9",
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(150, 200, 255),
    Font = Enum.Font.Gotham,
    TextSize = IS_MOBILE and 14 : 12,
    TextScaled = IS_MOBILE,
    Parent = Footer
})

-- ============================================
-- SISTEMA DE FUNCIONALIDADES
-- ============================================
-- Anti-AFK
if _G.Settings.AntiAFK then
    local VirtualUser = game:GetService("VirtualUser")
    Player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- NoClip system
RunService.Stepped:Connect(function()
    if _G.Settings.NoClip and Player.Character then
        for _, part in pairs(Player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Sistema de farm básico
spawn(function()
    while true do
        task.wait(0.5)
        
        if _G.Settings.AutoFarm and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                        local distance = (Player.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                        if distance < _G.Settings.FarmDistance then
                            Player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                            
                            if _G.Settings.AutoClick then
                                -- Simular clique
                                mouse1click()
                            end
                            break
                        end
                    end
                end
            end)
        end
        
        if _G.Settings.SpeedHack and Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = _G.Settings.WalkSpeed
        end
        
        if _G.Settings.JumpHack and Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.JumpPower = _G.Settings.JumpPower
        end
    end
end)

-- ============================================
-- CONTROLES DE INTERFACE
-- ============================================
if IS_MOBILE then
    -- No celular: botão flutuante controla a janela
    FloatingButton.MouseButton1Click:Connect(function()
        MainWindow.Visible = not MainWindow.Visible
        FloatingButton.Text = MainWindow.Visible and "✕" : "🎮"
        FloatingButton.BackgroundColor3 = MainWindow.Visible and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(120, 80, 200)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        MainWindow.Visible = false
        FloatingButton.Text = "🎮"
        FloatingButton.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
    end)
else
    -- No PC: F9 controla a janela
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F9 then
            MainWindow.Visible = not MainWindow.Visible
            Status.Text = MainWindow.Visible and "🎮 RedzHub v4.0 • Pressione F9 para esconder" : "🎮 RedzHub v4.0 • Pressione F9 para mostrar"
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

-- ============================================
-- NOTIFICAÇÃO INICIAL
-- ============================================
task.wait(1)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = IS_MOBILE and "📱 RedzHub Mobile" : "🎮 RedzHub v4.0",
    Text = IS_MOBILE and "Toque no botão 🎮 para abrir!" : "Pressione F9 para abrir/fechar!",
    Duration = 5,
    Icon = "rbxassetid://6023426925"
})

print("========================================")
print("📱 REDZHUB MOBILE v4.0")
print("👤 Player: " .. Player.Name)
print("📟 Platform: " .. (IS_MOBILE and "Mobile/Touch" : "PC"))
print("🎮 Controls: " .. (IS_MOBILE and "Touch buttons" : "F9 + Mouse"))
print("✅ Loaded successfully!")
print("========================================")

-- Retornar a interface
return ScreenGui
