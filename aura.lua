local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local v1 = Players.LocalPlayer

local function findRegisterHitEvent()
    local v3 = v1.Character
    if not v3 then
        return nil
    end

    for v2, v4 in ipairs(v3:GetChildren()) do
        local v9 = v4:FindFirstChild("ServerEvents")
        if v9 then
            local v8 = v9:FindFirstChild("RegisterHit")
            if v8 and v8:IsA("RemoteEvent") then
                return v8
            end
        end
    end
    return nil
end

local function getTargets()
    local v11 = {}
    
    for v2, v7 in ipairs(workspace:GetDescendants()) do
        if v7:IsA("Model") and v7:FindFirstChild("Humanoid") and v7 ~= v1.Character then
            local v12 = v7:FindFirstChild("Torso") or v7:FindFirstChild("HumanoidRootPart")
            if v12 then
                table.insert(v11, {model = v7, part = v12})
            end
        end
    end

    if #v11 == 0 and typeof(getnilinstances) == "function" then
        for v2, v7 in ipairs(getnilinstances()) do
            if v7:IsA("Model") then
                local v12 = v7:FindFirstChild("Torso") or v7:FindFirstChild("HumanoidRootPart")
                if v12 then
                    table.insert(v11, {model = v7, part = v12})
                end
            end
        end
    end

    return v11
end

task.spawn(function()
    while task.wait(0.2) do
        local v5 = findRegisterHitEvent()
        if v5 then
            local v11 = getTargets()
            if #v11 > 0 then
                local v6 = {}
                for v2, v10 in ipairs(v11) do
                    table.insert(v6, {
                        amount = 1,
                        target = v10.model,
                        is_friendly = false,
                        part = v10.part
                    })
                end

                if #v6 > 0 then
                    v5:FireServer(v6, {})
                end
            end
        end
    end
end)
