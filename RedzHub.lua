-- RedzHub X-TREME
local P = game.Players.LocalPlayer
local G = Instance.new("ScreenGui", game.CoreGui)

local F = Instance.new("Frame", G)
F.Size = UDim2.new(0,250,0,180)
F.Position = UDim2.new(0.5,-125,0.5,-90)
F.BackgroundColor3 = Color3.fromRGB(20,20,30)

local T = Instance.new("TextLabel", F)
T.Text = "⚡ RHX"
T.Size = UDim2.new(1,0,0,30)
T.BackgroundColor3 = Color3.fromRGB(100,0,200)
T.TextColor3 = Color3.fromRGB(255,255,255)
T.Font = Enum.Font.GothamBold

local function B(txt, y, col, act)
    local B = Instance.new("TextButton", F)
    B.Text = txt
    B.Size = UDim2.new(0.9,0,0,30)
    B.Position = UDim2.new(0.05,0,0,y)
    B.BackgroundColor3 = col
    B.TextColor3 = Color3.fromRGB(255,255,255)
    B.Font = Enum.Font.Gotham
    B.MouseButton1Click = act
end

B("FARM", 40, Color3.fromRGB(0,150,0), function()
    print("Farm activated")
end)

B("SPEED", 80, Color3.fromRGB(0,100,200), function()
    if P.Character then
        P.Character.Humanoid.WalkSpeed = 100
    end
end)

B("TELEPORT", 120, Color3.fromRGB(150,100,0), function()
    if P.Character then
        P.Character:MoveTo(Vector3.new(1072,16,1431))
    end
end)

print("RHX loaded")
