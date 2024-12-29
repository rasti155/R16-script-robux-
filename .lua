-- Server-Side Script
local marketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local purchaseRequest = ReplicatedStorage:WaitForChild("PurchaseRequest")

purchaseRequest.OnServerEvent:Connect(function(player)
    local robux = player.Leaderstats.Robux.Value

    if robux >= 100 and robux < 1000 then
        marketplaceService:PromptGamePassPurchase(player, 89294735)
    elseif robux >= 5 and robux < 100 then
        marketplaceService:PromptGamePassPurchase(player, 89295458)
    elseif robux >= 1000 and robux < 10000 then
        marketplaceService:PromptGamePassPurchase(player, 80672941)
    else
        marketplaceService:PromptGamePassPurchase(player, 89294735)
    end
end)

-- Client-Side Script
local player = game.Players.LocalPlayer
local marketplaceService = game:GetService("MarketplaceService")
local playerGui = player:WaitForChild("PlayerGui")
local purchaseRequest = game.ReplicatedStorage:WaitForChild("PurchaseRequest")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0.5, -100, 0.5, -25)
frame.BackgroundTransparency = 1
frame.Parent = playerGui

local purchaseButton = Instance.new("TextButton")
purchaseButton.Size = UDim2.new(1, 0, 1, 0)
purchaseButton.Text = "Loading..."
purchaseButton.BackgroundTransparency = 1
purchaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
purchaseButton.Parent = frame

local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 1, 0)
loadingLabel.Position = UDim2.new(0, 0, 0, 0)
loadingLabel.Text = "Loading..."
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Visible = true
loadingLabel.Parent = frame

local confirmLabel = Instance.new("TextLabel")
confirmLabel.Size = UDim2.new(1, 0, 1, 0)
confirmLabel.Position = UDim2.new(0, 0, 0, 0)
confirmLabel.Text = "Confirm"
confirmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmLabel.BackgroundTransparency = 1
confirmLabel.Visible = false
confirmLabel.Parent = frame

local function initiatePurchase()
    loadingLabel.Visible = false
    confirmLabel.Visible = true
    purchaseButton.Text = "Confirm"
end

local function confirmPurchase()
    purchaseButton.Text = "Loading..."
    confirmLabel.Visible = false
    loadingLabel.Visible = true
    purchaseRequest:FireServer()
end

wait(2)
initiatePurchase()

purchaseButton.MouseButton1Click:Connect(function()
    if confirmLabel.Visible then
        confirmPurchase()
    end
end)

