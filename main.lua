
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- local BOT_TOKEN = "aw"
-- local CHAT_ID = "aw"
-- local API_URL = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"

-- local function httpRequest(data)
--     if syn and syn.request then return syn.request(data)
--     elseif http_request then return http_request(data)
--     elseif request then return request(data)
--     elseif fluxus and fluxus.request then return fluxus.request(data)
--     elseif KRNL_LOADED and request then return request(data)
--     else error("Executor lo ga support http request") end
-- end

-- local function sendToTelegram(msg)
--     local body = {
--         chat_id = CHAT_ID,
--         text = msg
--     }
--     local data = HttpService:JSONEncode(body)

--     httpRequest({
--         Url = API_URL,
--         Method = "POST",
--         Headers = { ["Content-Type"] = "application/json" },
--         Body = data
--     })
-- end

local Window = Rayfield:CreateWindow({
   Name = "Mount Fvckers by dunhima",
   Icon = 0,
   LoadingTitle = "mZZ4 HUB",
   LoadingSubtitle = "by RzkyO & mZZ4",
   Theme = "Default",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local Tab = Window:CreateTab("Main")
local Section = Tab:CreateSection("- 3xplo Yang Tersedia -")

local InfiniteJumpEnabled = false

local Toggle = Tab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        InfiniteJumpEnabled = Value

        if InfiniteJumpEnabled then
            local Player = game:GetService("Players").LocalPlayer
            local UIS = game:GetService("UserInputService")

            if _G.InfiniteJumpConnection then
                _G.InfiniteJumpConnection:Disconnect()
            end

            _G.InfiniteJumpConnection = UIS.JumpRequest:Connect(function()
                if InfiniteJumpEnabled and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
                    Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if _G.InfiniteJumpConnection then
                _G.InfiniteJumpConnection:Disconnect()
                _G.InfiniteJumpConnection = nil
            end
        end
    end,
})

local AutoHealEnabled = false
local HealConnection

local Toggle = Tab:CreateToggle({
    Name = "Auto Heal",
    CurrentValue = false,
    Flag = "AutoHealToggle",
    Callback = function(Value)
        AutoHealEnabled = Value
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        if AutoHealEnabled then
            HealConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = math.min(humanoid.Health + 5, humanoid.MaxHealth)
                end
            end)
        else
            if HealConnection then HealConnection:Disconnect() HealConnection = nil end
        end
    end,
})

local godModeConnection = nil
local function enableGodMode(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Name ~= "GodHumanoid" then
        humanoid.Name = "GodHumanoid"

        godModeConnection = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health < 1 then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
    end
end

local function disableGodMode(character)
    if godModeConnection then
        godModeConnection:Disconnect()
        godModeConnection = nil
    end
    local humanoid = character:FindFirstChild("GodHumanoid")
    if humanoid then
        humanoid.Name = "Humanoid"
    end
end

local Toggle = Tab:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Flag = "GodModeToggle",
    Callback = function(Value)
        local character = player.Character or player.CharacterAdded:Wait()
        if Value then
            enableGodMode(character)
        else
            disableGodMode(character)
        end
    end,
})

player.CharacterAdded:Connect(function(character)
    wait(1)
    if Toggle.CurrentValue then
        enableGodMode(character)
    else
        disableGodMode(character)
    end
end)

local Toggle = Tab:CreateToggle({
    Name = "Click Teleport",
    CurrentValue = false,
    Flag = "ClickTP_Toggle",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()

        local existingTool = player.Backpack:FindFirstChild("Equip to Click TP")
            or player.Character:FindFirstChild("Equip to Click TP")

        if Value then
            if not existingTool then
                local tool = Instance.new("Tool")
                tool.RequiresHandle = false
                tool.Name = "Equip to Click TP"

                tool.Activated:Connect(function()
                    local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
                    pos = CFrame.new(pos.X, pos.Y, pos.Z)
                    player.Character.HumanoidRootPart.CFrame = pos
                end)

                tool.Parent = player.Backpack
            end
        else
            if existingTool then existingTool:Destroy() end
        end
    end,
})

-- local Toggle = Tab:CreateToggle({
--     Name = "Click Teleport To Get Coordinate",
--     CurrentValue = false,
--     Flag = "ClickTP_Coords_Toggle",
--     Callback = function(Value)
--         local player = game.Players.LocalPlayer
--         local mouse = player:GetMouse()

--         local existingTool = player.Backpack:FindFirstChild("Equip to Click TP Coords")
--             or player.Character:FindFirstChild("Equip to Click TP Coords")

--         if Value then
--             if not existingTool then
--                 local tool = Instance.new("Tool")
--                 tool.RequiresHandle = false
--                 tool.Name = "Equip to Click TP Coords"

--                 tool.Activated:Connect(function()
--                     local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
--                     pos = CFrame.new(pos.X, pos.Y, pos.Z)
--                     player.Character.HumanoidRootPart.CFrame = pos

--                     local coords = player.Character.HumanoidRootPart.Position
--                     local msg = string.format(
--                         "Player %s Teleported!\nKoordinat:\n(%.2f,%.2f,%.2f)",
--                         player.Name, coords.X, coords.Y, coords.Z
--                     )

--                     -- Kirim ke Telegram
--                     sendToTelegram(msg)
--                 end)

--                 tool.Parent = player.Backpack
--             end
--         else
--             if existingTool then existingTool:Destroy() end
--         end
--     end,
-- })

local Slider = Tab:CreateSlider({
   Name = "WalkSpeed",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoid = character:FindFirstChildOfClass("Humanoid")
     
      if humanoid then
          humanoid.WalkSpeed = Value
      end
   end,
})

-- Players Tab

local function getRoot(model)
    if not model then return nil end
    return model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("Torso")
        or model:FindFirstChild("UpperTorso")
end

local function typeOf(v)
    local tf = typeof or function(x) return type(x) end
    return tf(v)
end

local function getMyHRP()
    local myChar = player.Character or player.CharacterAdded:Wait()
    local myHRP  = getRoot(myChar) or myChar:WaitForChild("HumanoidRootPart", 8)
    return myChar, myHRP
end

local function tpToTarget(targetPlayer)
    print("[TP] start to", targetPlayer and targetPlayer.Name)

    local myChar = player.Character or player.CharacterAdded:Wait()
    local myHRP  = getRoot(myChar) or myChar:WaitForChild("HumanoidRootPart", 8)
    if not myHRP then
        print("[TP] myHRP not found")
        return false, "HRP kamu gak ditemukan."
    end

    local tChar = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
    local tHRP  = getRoot(tChar) or tChar:WaitForChild("HumanoidRootPart", 8)
    if not tHRP then
        print("[TP] target HRP not found")
        return false, "Target belum punya HRP."
    end

    local destCFrame = tHRP.CFrame + Vector3.new(0, 2.5, 0)

    pcall(function()
        myHRP.AssemblyLinearVelocity = Vector3.new()
        myHRP.AssemblyAngularVelocity = Vector3.new()
    end)

    for tries = 1, 4 do
        local ok = pcall(function()
            myHRP.CFrame = destCFrame
        end)
        if ok then
            print("[TP] CFrame set ok on try", tries)
            return true
        end
        task.wait(0.12)
        myChar = player.Character or player.CharacterAdded:Wait()
        myHRP  = getRoot(myChar) or myChar:WaitForChild("HumanoidRootPart", 8)
        if not myHRP then
            print("[TP] myHRP lost after retry")
            return false, "HRP kamu hilang saat teleport."
        end
    end
    print("[TP] CFrame method failed, fallback to PivotTo")

    for tries = 1, 3 do
        local ok = pcall(function()
            if not myChar.PrimaryPart then
                myChar.PrimaryPart = getRoot(myChar)
            end
            myChar:PivotTo(destCFrame)
        end)
        if ok then
            print("[TP] PivotTo ok on try", tries)
            return true
        end
        task.wait(0.12)
    end
    print("[TP] PivotTo failed, fallback to Humanoid:MoveTo")

    local hum = myChar:FindFirstChildOfClass("Humanoid")
    if hum then
        local reached = false
        local conn
        conn = hum.MoveToFinished:Connect(function(ok)
            reached = ok
            if conn then conn:Disconnect() end
        end)
        pcall(function()
            hum:MoveTo(destCFrame.Position)
        end)
        local t0 = os.clock()
        while os.clock() - t0 < 2 do
            if reached then break end
            task.wait(0.1)
        end
        if reached then
            print("[TP] MoveTo reached")
            return true
        end
    end

    print("[TP] all methods failed")
    return false, "Gagal teleport (CFrame/PivotTo/MoveTo). Mungkin diblokir anti-teleport."
end

local PlayerTab = Window:CreateTab("👥 Players", nil)

local optionToPlayer = {}
local selectedLabel  = nil

local function makeLabel(p)
    if p == player then
        return string.format("%s (You) [%d]", p.Name, p.UserId)
    else
        return string.format("%s [%d]", p.Name, p.UserId)
    end
end

local function buildOptions()
    optionToPlayer = {}
    local opts = {}
    for _, p in ipairs(Players:GetPlayers()) do
        local label = makeLabel(p)
        optionToPlayer[label] = p
        table.insert(opts, label)
    end
    return opts
end

local function getSelected()
    if selectedLabel and optionToPlayer[selectedLabel] then
        return selectedLabel
    end
    local opts = buildOptions()
    if #opts > 0 then
        selectedLabel = opts[1]
        return selectedLabel
    end
    return nil
end

local initialOpts = buildOptions()

local function dropdownSetOptionsSafe(dd, opts)
    if not dd then return end
    local ok = false
    if dd.SetOptions then
        ok = pcall(function() dd:SetOptions(opts) end)
    end
    if (not ok) and dd.Refresh then
        pcall(function() dd:Refresh(opts, opts[1]) end)
    end
end

local function dropdownSetValueSafe(dd, value)
    if not dd then return end
    if dd.SetOption then
        pcall(function() dd:SetOption(value) end)
        return
    end
    if dd.Set then
        pcall(function() dd:Set(value) end)
        return
    end
    if dd.Refresh then
        pcall(function()
            local opts = buildOptions()
            dd:Refresh(opts, value)
        end)
    end
end

local PlayerDropdown = PlayerTab:CreateDropdown({
    Name = "Pilih Player",
    Options = initialOpts,
    CurrentOption = initialOpts[1] or nil,
    Callback = function(label)
        if typeOf(label) == "table" then
            label = label[1]
        end
        selectedLabel = label
        local target = optionToPlayer[label]
        if target then
            Rayfield:Notify({
                Title   = "Target Dipilih",
                Content = string.format("-> %s (%d)", target.Name, target.UserId),
                Duration = 1.25
            })
        end
    end,
})

if initialOpts[1] then
    selectedLabel = initialOpts[1]
end

PlayerTab:CreateButton({
    Name = "Refresh List",
    Callback = function()
        local opts = buildOptions()
        dropdownSetOptionsSafe(PlayerDropdown, opts)
        if #opts > 0 then
            dropdownSetValueSafe(PlayerDropdown, opts[1])
            selectedLabel = opts[1]
        else
            selectedLabel = nil
            Rayfield:Notify({ Title="Players", Content="Belum ada pemain terdeteksi.", Duration=1.5 })
        end
        Rayfield:Notify({ Title="Players", Content="List di-refresh ("..tostring(#opts).." pemain).", Duration=1.2 })
    end,
})

local function autoRefresh()
    local opts = buildOptions()
    dropdownSetOptionsSafe(PlayerDropdown, opts)
    if #opts > 0 then
        selectedLabel = (selectedLabel and optionToPlayer[selectedLabel]) and selectedLabel or opts[1]
    else
        selectedLabel = nil
    end
end

Players.PlayerAdded:Connect(autoRefresh)
Players.PlayerRemoving:Connect(function()
    autoRefresh()
    if selectedLabel and not optionToPlayer[selectedLabel] then
        selectedLabel = nil
    end
end)

PlayerTab:CreateButton({
    Name = "Teleport To Player",
    Callback = function()
        print("[BTN] Teleport pressed")
        local label = getSelected()
        print("[BTN] selected label =", label)

        if not label or not optionToPlayer[label] then
            print("[BTN] label invalid, rebuilding options")
            local opts = buildOptions()
            dropdownSetOptionsSafe(PlayerDropdown, opts)
            selectedLabel = opts[1]
            if not selectedLabel then
                Rayfield:Notify({ Title="Players", Content="Belum ada pemain di server.", Duration=1.5 })
                return
            end
            label = selectedLabel
        end

        local target = optionToPlayer[label]
        print("[BTN] target =", target and target.Name, target and target.UserId)

        if not target then
            Rayfield:Notify({ Title="Teleport", Content="Target tidak valid.", Duration=1.5 })
            return
        end
        if target == player then
            Rayfield:Notify({ Title="Teleport", Content="Tidak bisa teleport ke diri sendiri.", Duration=1.5 })
            return
        end

        local ok, err = tpToTarget(target)
        if ok then
            Rayfield:Notify({ Title="Teleport", Content="Berhasil teleport ke "..label, Duration=1.5 })
        else
            Rayfield:Notify({ Title="Teleport", Content="Gagal: "..tostring(err), Duration=2 })
            print("[TP] error:", err)
        end
    end,
})

-- local Tab = Window:CreateTab("Teleport")
-- local Section = Tab:CreateSection("- 3xplo Yang Tersedia -")

-- local Toggle = Tab:CreateToggle({
--     Name = "Teleport to CP1",
--     CurrentValue = false,
--     Flag = "Toggle1",
--     Callback = function(Value)
--         if Value then
--             local player = game.Players.LocalPlayer
--             local character = player.Character or player.CharacterAdded:Wait()
--             local hrp = character:WaitForChild("HumanoidRootPart")

--             -- Ganti ini ke koordinat tujuan kamu
--             local targetPosition = CFrame.new(-421.68,193.49,553.80)

--             hrp.CFrame = targetPosition
--         end
--         -- Kalau Value == false, nggak ngapa-ngapain
--     end,
-- })

-- local Toggle = Tab:CreateToggle({
--     Name = "Teleport to CP2",
--     CurrentValue = false,
--     Flag = "Toggle1",
--     Callback = function(Value)
--         if Value then
--             local player = game.Players.LocalPlayer
--             local character = player.Character or player.CharacterAdded:Wait()
--             local hrp = character:WaitForChild("HumanoidRootPart")

--             -- Ganti ini ke koordinat tujuan kamu
--             local targetPosition = CFrame.new(-630.61,580.31,1136.20)

--             hrp.CFrame = targetPosition
--         end
--         -- Kalau Value == false, nggak ngapa-ngapain
--     end,
-- })

-- local Toggle = Tab:CreateToggle({
--     Name = "Teleport to CP3",
--     CurrentValue = false,
--     Flag = "Toggle1",
--     Callback = function(Value)
--         if Value then
--             local player = game.Players.LocalPlayer
--             local character = player.Character or player.CharacterAdded:Wait()
--             local hrp = character:WaitForChild("HumanoidRootPart")

--             -- Ganti ini ke koordinat tujuan kamu
--             local targetPosition = CFrame.new(-894.48,691.89,1222.08)

--             hrp.CFrame = targetPosition
--         end
--         -- Kalau Value == false, nggak ngapa-ngapain
--     end,
-- })

-- local Toggle = Tab:CreateToggle({
--     Name = "Teleport to CP4",
--     CurrentValue = false,
--     Flag = "Toggle1",
--     Callback = function(Value)
--         if Value then
--             local player = game.Players.LocalPlayer
--             local character = player.Character or player.CharacterAdded:Wait()
--             local hrp = character:WaitForChild("HumanoidRootPart")

--             -- Ganti ini ke koordinat tujuan kamu
--             local targetPosition = CFrame.new(-389.85,1043.46,2045.04)

--             hrp.CFrame = targetPosition
--         end
--         -- Kalau Value == false, nggak ngapa-ngapain
--     end,
-- })

-- local Toggle = Tab:CreateToggle({
--     Name = "Teleport to CP5",
--     CurrentValue = false,
--     Flag = "Toggle1",
--     Callback = function(Value)
--         if Value then
--             local player = game.Players.LocalPlayer
--             local character = player.Character or player.CharacterAdded:Wait()
--             local hrp = character:WaitForChild("HumanoidRootPart")

--             -- Ganti ini ke koordinat tujuan kamu
--             local targetPosition = CFrame.new(1189.22,10121.51,2295.03)

--             hrp.CFrame = targetPosition
--         end
--         -- Kalau Value == false, nggak ngapa-ngapain
--     end,
-- })

-- local Toggle = Tab:CreateToggle({
--     Name = "Teleport to SUMMIT",
--     CurrentValue = false,
--     Flag = "Toggle1",
--     Callback = function(Value)
--         if Value then
--             local player = game.Players.LocalPlayer
--             local character = player.Character or player.CharacterAdded:Wait()
--             local hrp = character:WaitForChild("HumanoidRootPart")

--             -- Ganti ini ke koordinat tujuan kamu
--             local targetPosition = CFrame.new(-120.01,10832.71,30
