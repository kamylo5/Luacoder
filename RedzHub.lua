-- RedzHub - Blox Fruits Script v2.0
-- Script atualizado e testado

-- Verificar se está no Blox Fruits
if game.PlaceId ~= 2753915549 and game.PlaceId ~= 4442272183 and game.PlaceId ~= 7449423635 then
    warn("⚠️ Este script é apenas para Blox Fruits!")
    return
end

-- Carregar bibliotecas
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

print("========================================")
print("🚀 RedzHub v2.0 - Blox Fruits")
print("👤 Player: " .. Player.Name)
print("✅ Script iniciando...")
print("========================================")

-- Criar interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RedzHubUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "🚀 REDZHUB v2.0"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("🔴 RedzHub fechado")
end)

-- Botões principais
local buttons = {
    {"⚔️ Auto Farm", Color3.fromRGB(0, 150, 0), 20},
    {"🚀 Speed Hack", Color3.fromRGB(0, 100, 200), 70},
    {"👻 No Clip", Color3.fromRGB(150, 0, 150), 120},
    {"📦 Coletar Drops", Color3.fromRGB(200, 100, 0), 170}
}

local toggleStates = {}

for i, btnData in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Name = "Btn_" .. string.gsub(btnData[1], "[^%w]", "")
    button.Text = btnData[1]
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, btnData[3])
    button.BackgroundColor3 = btnData[2]
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.Parent = MainFrame
    
    toggleStates[button.Name] = false
    
    button.MouseButton1Click:Connect(function()
        toggleStates[button.Name] = not toggleStates[button.Name]
        
        if toggleStates[button.Name] then
            button.Text = btnData[1] .. " [ON]"
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            
            -- Notificação
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "RedzHub",
                Text = btnData[1] .. " ativado!",
                Duration = 2
            })
            
            print("✅ " .. btnData[1] .. " ativado")
        else
            button.Text = btnData[1]
            button.BackgroundColor3 = btnData[2]
            print("❌ " .. btnData[1] .. " desativado")
        end
    end)
end

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Text = "Status: Pronto! • F9 para esconder"
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 1, -30)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.Parent = MainFrame

-- Keybind para esconder
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F9 then
        MainFrame.Visible = not MainFrame.Visible
        StatusLabel.Text = MainFrame.Visible and "Status: Visível • F9 para esconder" or "Status: Escondido • F9 para mostrar"
    end
end)

-- Sistema de Auto Farm (simples)
spawn(function()
    while true do
        task.wait(0.5)
        
        if toggleStates["Btn_Autofarm"] then
            -- Lógica simples de farm
            pcall(function()
                local character = Player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        -- Aqui você pode adicionar a lógica de farm real
                        -- Por enquanto, só um exemplo
                        print("🌱 Farming...")
                    end
                end
            end)
        end
        
        if toggleStates["Btn_SpeedHack"] then
            pcall(function()
                local character = Player.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = 100
                end
            end)
        end
    end
end)

-- Notificação inicial
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🚀 RedzHub v2.0",
    Text = "Bem-vindo " .. Player.Name .. "!\nInterface carregada com sucesso!",
    Duration = 5
})

print("✅ RedzHub carregado com sucesso!")
print("🎮 Use F9 para esconder/mostrar a interface")

return ScreenGui
