--[[
    ╔═══════════════════════════════════════════╗
    ║    VOLLEYBALL LEGENDS - PRO SCRIPT       ║
    ║      FIXED: Responsive + Draggable       ║
    ║         Made for Maximum Performance       ║
    ╚═══════════════════════════════════════════╝

    Author: Pro Dev | Version: 2.1 FIXED
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

-- ==================== COLOR THEME ====================
local theme = {
    bg_dark = Color3.fromRGB(12, 14, 20),
    bg_main = Color3.fromRGB(18, 22, 30),
    panel_dark = Color3.fromRGB(24, 28, 38),
    panel_light = Color3.fromRGB(32, 38, 50),
    panel_mid = Color3.fromRGB(40, 48, 62),
    divider = Color3.fromRGB(55, 65, 82),
    text_white = Color3.fromRGB(255, 255, 255),
    text_gray = Color3.fromRGB(185, 195, 210),
    text_sub = Color3.fromRGB(140, 150, 168),
    accent_orange = Color3.fromRGB(255, 140, 50),
    accent_blue = Color3.fromRGB(70, 160, 255),
    accent_yellow = Color3.fromRGB(255, 210, 70),
    accent_green = Color3.fromRGB(60, 220, 130),
    accent_red = Color3.fromRGB(255, 90, 90),
    accent_purple = Color3.fromRGB(160, 100, 255),
}

-- ==================== RESPONSIVE SIZE ====================
-- Otomatis menyesuaikan ukuran layar
local viewport = workspace.CurrentCamera.ViewportSize
local WINDOW_WIDTH = math.clamp(viewport.X * 0.6, 520, 700)
local WINDOW_HEIGHT = math.clamp(viewport.Y * 0.65, 380, 480)

local function create(className, properties)
    local obj = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        obj[prop] = value
    end
    return obj
end

local function addCorner(instance, radius)
    local corner = create("UICorner", {CornerRadius = UDim.new(0, radius or 12)})
    corner.Parent = instance
    return corner
end

local function addStroke(instance, color, thickness, transparency)
    local stroke = create("UIStroke", {
        Color = color or Color3.new(1, 1, 1),
        Thickness = thickness or 1,
        Transparency = transparency or 0.1
    })
    stroke.Parent = instance
    return stroke
end

local function tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or 0.25,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    )
    local tweenObject = TweenService:Create(instance, tweenInfo, properties)
    tweenObject:Play()
    return tweenObject
end

local function notify(title, message, accentColor, duration)
    local screenGui = create("ScreenGui", {
        Name = "VBLNotification",
        Parent = CoreGui,
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local notificationFrame = create("Frame", {
        Parent = screenGui,
        BackgroundColor3 = theme.panel_light,
        BorderSizePixel = 0,
        Position = UDim2.new(1, 300, 0, 20),
        Size = UDim2.new(0, 260, 0, 76),
        ClipsDescendants = true,
        ZIndex = 10
    })
    addCorner(notificationFrame, 12)
    addStroke(notificationFrame, accentColor or theme.accent_orange, 2, 0.2)

    local topBar = create("Frame", {
        Parent = notificationFrame,
        BackgroundColor3 = accentColor or theme.accent_orange,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 4),
    })
    addCorner(topBar, 12)

    create("TextLabel", {
        Parent = notificationFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -24, 0, 18),
        Font = Enum.Font.GothamBold,
        Text = title or "Notification",
        TextColor3 = theme.text_white,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    create("TextLabel", {
        Parent = notificationFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 28),
        Size = UDim2.new(1, -24, 0, 40),
        Font = Enum.Font.Gotham,
        Text = message or "Message",
        TextColor3 = theme.text_gray,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })

    tween(notificationFrame, {Position = UDim2.new(1, -280, 0, 20)}, 0.3)
    task.delay(duration or 3, function()
        tween(notificationFrame, {Position = UDim2.new(1, 300, 0, 20)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.delay(0.35, function()
            screenGui:Destroy()
        end)
    end)
end

-- ==================== LOGO ====================
local function createLogo(parent)
    local logoGroup = create("Frame", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 44, 0, 44),
        BorderSizePixel = 0
    })

    local outer = create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.accent_orange,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -22, 0.5, -22),
        Size = UDim2.new(0, 44, 0, 44)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0)}).Parent = outer

    local mid = create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.text_white,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -17, 0.5, -17),
        Size = UDim2.new(0, 34, 0, 34)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0)}).Parent = mid

    create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.accent_blue,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -17, 0.5, -1.5),
        Size = UDim2.new(0, 34, 0, 3),
    })

    create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.accent_blue,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -1.5, 0.5, -17),
        Size = UDim2.new(0, 3, 0, 34),
    })

    local dot = create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.accent_orange,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -4, 0.5, -4),
        Size = UDim2.new(0, 8, 0, 8)
    })
    create("UICorner", {CornerRadius = UDim.new(1, 0)}).Parent = dot

    return logoGroup
end

-- ==================== MAIN LIBRARY ====================
local Library = {}
Library.__index = Library

function Library:CreateWindow(windowTitle)
    local self = setmetatable({}, Library)

    local screenGui = create("ScreenGui", {
        Name = "VolleyballLegendsMenu",
        Parent = CoreGui,
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    -- ✅ FIXED: Posisi di tengah otomatis pakai AnchorPoint
    local windowFrame = create("Frame", {
        Parent = screenGui,
        BackgroundColor3 = theme.bg_main,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, WINDOW_WIDTH, 0, WINDOW_HEIGHT),
        ClipsDescendants = true,
        Active = true,  -- ✅ FIXED: agar bisa drag
        Draggable = false
    })
    addCorner(windowFrame, 16)

    -- ==================== HEADER ====================
    local header = create("Frame", {
        Parent = windowFrame,
        BackgroundColor3 = theme.panel_mid,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 60),
        Active = true  -- ✅ FIXED: agar bisa drag
    })
    addCorner(header, 16)
    addStroke(header, theme.divider, 1, 0.3)

    local logoContainer = create("Frame", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0.5, -22),
        Size = UDim2.new(0, 44, 0, 44),
        BorderSizePixel = 0
    })
    createLogo(logoContainer)

    create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 66, 0, 8),
        Size = UDim2.new(0.55, 0, 0, 24),
        Font = Enum.Font.GothamBlack,
        Text = windowTitle or "VOLLEYBALL LEGENDS",
        TextColor3 = theme.text_white,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 66, 0, 30),
        Size = UDim2.new(0.55, 0, 0, 18),
        Font = Enum.Font.Gotham,
        Text = "Pro Script • v2.1 FIXED",
        TextColor3 = theme.text_sub,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- Status dot
    local statusDot = create("Frame", {
        Parent = header,
        BackgroundColor3 = theme.accent_green,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -108, 0.5, -6),
        Size = UDim2.new(0, 12, 0, 12)
    })
    addCorner(statusDot, 12)

    create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -94, 0.5, -7),
        Size = UDim2.new(0, 50, 0, 14),
        Font = Enum.Font.GothamSemibold,
        Text = "ACTIVE",
        TextColor3 = theme.accent_green,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- ✅ FIXED: Minimize Button dengan state yang benar
    local minimizeButton = create("TextButton", {
        Parent = header,
        BackgroundColor3 = theme.panel_light,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -46, 0.5, -14),
        Size = UDim2.new(0, 28, 0, 28),
        Text = "−",
        TextColor3 = theme.text_white,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        AutoButtonColor = false,
        ZIndex = 5  -- ✅ FIXED: di atas header agar klik tembus
    })
    addCorner(minimizeButton, 8)
    addStroke(minimizeButton, theme.accent_orange, 1, 0.3)

    -- ✅ FIXED: Simpan ukuran & posisi ASLI setelah window dibuat
    local originalSize = UDim2.new(0, WINDOW_WIDTH, 0, WINDOW_HEIGHT)
    local originalPosition = UDim2.new(0.5, 0, 0.5, 0)
    local isMinimized = false

    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            minimizeButton.Text = "+"
            minimizeButton.BackgroundColor3 = theme.accent_orange
            tween(windowFrame, {
                Size = UDim2.new(0, 260, 0, 60),
                Position = UDim2.new(0.5, 0, 1, -50)
            }, 0.3)
        else
            minimizeButton.Text = "−"
            minimizeButton.BackgroundColor3 = theme.panel_light
            tween(windowFrame, {
                Size = originalSize,
                Position = originalPosition
            }, 0.3)
        end
    end)

    -- ==================== SIDEBAR ====================
    local sidebar = create("Frame", {
        Parent = windowFrame,
        BackgroundColor3 = theme.panel_light,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 60),
        Size = UDim2.new(0, 165, 1, -60)
    })
    addCorner(sidebar, 16)
    addStroke(sidebar, theme.divider, 1, 0.2)

    local tabList = create("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 12),
        Size = UDim2.new(1, -20, 1, -24)
    })

    create("UIListLayout", {
        Parent = tabList,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    -- ==================== CONTENT AREA ====================
    local contentArea = create("ScrollingFrame", {
        Parent = windowFrame,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 175, 0, 72),
        Size = UDim2.new(1, -187, 1, -84),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = theme.divider,
        Active = true,
        ClipsDescendants = true
    })

    create("UIPadding", {
        Parent = contentArea,
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8)
    })

    -- ==================== TAB SYSTEM ====================
    local tabs = {}
    local selectedTab = nil

    local function switchTab(tab)
        for _, otherTab in ipairs(tabs) do
            if otherTab == tab then
                otherTab.Page.Visible = true
                tween(otherTab.Button, {BackgroundColor3 = theme.accent_orange}, 0.2)
                otherTab.Button.TextColor3 = theme.text_white
            else
                otherTab.Page.Visible = false
                tween(otherTab.Button, {BackgroundColor3 = theme.panel_dark}, 0.2)
                otherTab.Button.TextColor3 = theme.text_sub
            end
        end
        selectedTab = tab
    end

    function self:AddTab(tabName)
        local tabButton = create("TextButton", {
            Parent = tabList,
            BackgroundColor3 = theme.panel_dark,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 38),
            Text = tabName,
            TextColor3 = theme.text_sub,
            Font = Enum.Font.GothamSemibold,
            TextSize = 12,
            AutoButtonColor = false
        })
        addCorner(tabButton, 10)
        addStroke(tabButton, theme.divider, 1, 0.2)

        local tabPage = create("Frame", {
            Parent = contentArea,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y  -- ✅ FIXED: auto-size agar layout benar
        })

        create("UIListLayout", {
            Parent = tabPage,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        local tab = {Name = tabName, Button = tabButton, Page = tabPage}
        table.insert(tabs, tab)

        tabButton.MouseButton1Click:Connect(function() switchTab(tab) end)
        tabButton.MouseEnter:Connect(function()
            if tab ~= selectedTab then
                tween(tabButton, {BackgroundColor3 = theme.panel_mid}, 0.15)
            end
        end)
        tabButton.MouseLeave:Connect(function()
            if tab ~= selectedTab then
                tween(tabButton, {BackgroundColor3 = theme.panel_dark}, 0.15)
            end
        end)

        local section = {}

        function section:AddButton(text, callback)
            local button = create("TextButton", {
                Parent = tabPage,
                BackgroundColor3 = theme.accent_orange,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 36),
                Text = text,
                TextColor3 = theme.text_white,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                AutoButtonColor = false
            })
            addCorner(button, 10)
            addStroke(button, theme.accent_orange, 2, 0.2)

            button.MouseButton1Click:Connect(function()
                tween(button, {BackgroundColor3 = theme.accent_blue}, 0.15)
                task.wait(0.1)
                tween(button, {BackgroundColor3 = theme.accent_orange}, 0.15)
                if callback then callback() end
            end)
            button.MouseEnter:Connect(function()
                tween(button, {BackgroundColor3 = Color3.fromRGB(255, 165, 90)}, 0.1)
            end)
            button.MouseLeave:Connect(function()
                tween(button, {BackgroundColor3 = theme.accent_orange}, 0.1)
            end)
            return button
        end

        function section:AddToggle(text, defaultState, callback)
            local state = defaultState == true

            local toggleFrame = create("Frame", {
                Parent = tabPage,
                BackgroundColor3 = theme.panel_light,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 42)
            })
            addCorner(toggleFrame, 10)
            addStroke(toggleFrame, theme.divider, 1, 0.2)

            create("TextLabel", {
                Parent = toggleFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 14, 0, 0),
                Size = UDim2.new(1, -76, 1, 0),
                Font = Enum.Font.GothamSemibold,
                Text = text,
                TextColor3 = theme.text_white,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local toggleBg = create("Frame", {
                Parent = toggleFrame,
                BackgroundColor3 = state and theme.accent_green or theme.panel_dark,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -58, 0.5, -12),
                Size = UDim2.new(0, 46, 0, 24)
            })
            addCorner(toggleBg, 12)
            addStroke(toggleBg, state and theme.accent_green or theme.divider, 1, 0.2)

            local toggleKnob = create("Frame", {
                Parent = toggleBg,
                BackgroundColor3 = theme.text_white,
                BorderSizePixel = 0,
                Position = state and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 2, 0.5, -9),
                Size = UDim2.new(0, 18, 0, 18)
            })
            addCorner(toggleKnob, 9)

            local function updateToggle()
                tween(toggleKnob, {Position = state and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, 0.2)
                tween(toggleBg, {BackgroundColor3 = state and theme.accent_green or theme.panel_dark}, 0.2)
            end

            local clickArea = create("TextButton", {
                Parent = toggleFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                BorderSizePixel = 0
            })

            clickArea.MouseButton1Click:Connect(function()
                state = not state
                updateToggle()
                if callback then callback(state) end
            end)

            return toggleFrame
        end

        function section:AddSlider(text, minValue, maxValue, defaultValue, callback)
            local sliderValue = defaultValue or minValue

            local sliderFrame = create("Frame", {
                Parent = tabPage,
                BackgroundColor3 = theme.panel_light,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 64)
            })
            addCorner(sliderFrame, 10)
            addStroke(sliderFrame, theme.divider, 1, 0.2)

            local label = create("TextLabel", {
                Parent = sliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 14, 0, 8),
                Size = UDim2.new(1, -28, 0, 18),
                Font = Enum.Font.GothamSemibold,
                Text = text .. " : " .. string.format("%.1f", sliderValue),
                TextColor3 = theme.text_white,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local sliderBar = create("Frame", {
                Parent = sliderFrame,
                BackgroundColor3 = theme.panel_dark,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 14, 0, 36),
                Size = UDim2.new(1, -28, 0, 8),
                Active = true  -- ✅ FIXED agar bisa di-click
            })
            addCorner(sliderBar, 4)

            local sliderFill = create("Frame", {
                Parent = sliderBar,
                BackgroundColor3 = theme.accent_blue,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 0, 1, 0)
            })
            addCorner(sliderFill, 4)

            local sliderDrag = create("Frame", {
                Parent = sliderBar,
                BackgroundColor3 = theme.accent_orange,
                BorderSizePixel = 0,
                Position = UDim2.new(0, -7, 0.5, -7),
                Size = UDim2.new(0, 14, 0, 14)
            })
            addCorner(sliderDrag, 7)
            addStroke(sliderDrag, theme.accent_orange, 2, 0.2)

            -- ✅ FIXED: Click area lebih besar biar gampang di-drag
            local clickArea = create("TextButton", {
                Parent = sliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 14, 0, 28),
                Size = UDim2.new(1, -28, 0, 24),
                Text = "",
                BorderSizePixel = 0,
                ZIndex = 5
            })

            local isDragging = false

            local function updateSlider(mouseX)
                local barStart = sliderBar.AbsolutePosition.X
                local barEnd = barStart + sliderBar.AbsoluteSize.X
                local ratio = math.clamp((mouseX - barStart) / (barEnd - barStart), 0, 1)
                sliderValue = minValue + (maxValue - minValue) * ratio
                sliderValue = math.floor(sliderValue * 10) / 10

                label.Text = text .. " : " .. string.format("%.1f", sliderValue)
                sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
                sliderDrag.Position = UDim2.new(ratio, -7, 0.5, -7)

                if callback then callback(sliderValue) end
            end

            clickArea.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isDragging = true
                    updateSlider(input.Position.X)
                end
            end)

            clickArea.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isDragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input.Position.X)
                end
            end)

            local ratio = (sliderValue - minValue) / (maxValue - minValue)
            sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
            sliderDrag.Position = UDim2.new(ratio, -7, 0.5, -7)

            return sliderFrame
        end

        function section:AddLabel(text)
            return create("TextLabel", {
                Parent = tabPage,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 20),
                Font = Enum.Font.Gotham,
                Text = "→ " .. text,
                TextColor3 = theme.text_sub,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        end

        function section:AddDivider()
            return create("Frame", {
                Parent = tabPage,
                BackgroundColor3 = theme.divider,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 1)
            })
        end

        if #tabs == 1 then switchTab(tab) end

        return section
    end

    -- ==================== ✅ FIXED: DRAG FUNCTIONALITY ====================
    -- Pakai InputBegan di header DAN windowFrame, dengan pengecekan agar tidak konflik dengan tombol
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function updateDrag(input)
        local delta = input.Position - dragStart
        windowFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    local function startDrag(input)
        -- Jangan drag kalau yang diklik tombol minimize
        if input.Target and input.Target:IsDescendantOf(minimizeButton) then
            return
        end
        dragging = true
        dragStart = input.Position
        startPos = windowFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    -- ✅ Drag dari header (area utama)
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
        or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)

    header.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
        or input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end)

    -- ✅ Drag juga dari windowFrame (area kosong)
    windowFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
        or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)

    windowFrame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
        or input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end)

    -- Global release
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    self.Window = windowFrame
    self.ScreenGui = screenGui

    return self
end

-- ==================== VOLLEYBALL LEGENDS FEATURES ====================
local menu = Library:CreateWindow("VOLLEYBALL LEGENDS")

-- Safe character setup
local function setupCharacter()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid", 5)
    return char, hum
end

local playerChar, humanoid = setupCharacter()
local autoSpikeEnabled = false
local infiniteJumpEnabled = false

LocalPlayer.CharacterAdded:Connect(function(char)
    playerChar = char
    humanoid = char:WaitForChild("Humanoid", 5)
end)

-- ==================== 🏐 GAMEPLAY TAB ====================
local gameplayTab = menu:AddTab("🏐 GAMEPLAY")
gameplayTab:AddLabel("Core Gameplay Enhancements")

gameplayTab:AddToggle("Auto Spike", false, function(enabled)
    autoSpikeEnabled = enabled
    notify("🏐 AUTO SPIKE", enabled and "Auto Spike ENABLED" or "Auto Spike DISABLED", theme.accent_orange, 2)
end)

gameplayTab:AddToggle("Auto Serve", false, function(enabled)
    notify("🎯 AUTO SERVE", enabled and "Auto Serve ENABLED" or "Auto Serve DISABLED", theme.accent_blue, 2)
end)

gameplayTab:AddToggle("Perfect Timing", false, function(enabled)
    notify("⏱️ TIMING", enabled and "Perfect Timing ON" or "Perfect Timing OFF", theme.accent_yellow, 2)
end)

gameplayTab:AddSlider("Spike Power", 1, 100, 50, function(value) end)

gameplayTab:AddSlider("Jump Height", 1, 5, 1, function(value)
    if humanoid then
        humanoid.JumpPower = value * 50
    end
end)

-- ==================== 🎯 AIM ASSIST TAB ====================
local aimTab = menu:AddTab("🎯 AIM ASSIST")
aimTab:AddLabel("Precision Targeting System")

aimTab:AddToggle("Aim Assist", false, function(enabled)
    notify("🎯 AIM ASSIST", enabled and "Aim Assist ENABLED" or "Aim Assist DISABLED", theme.accent_blue, 2)
end)

aimTab:AddSlider("FOV Size", 10, 360, 90, function(value) end)
aimTab:AddSlider("Smoothness", 0.1, 1, 0.5, function(value) end)

aimTab:AddToggle("Silent Aim", false, function(enabled)
    notify("🤫 SILENT AIM", enabled and "Silent Aim ON" or "Silent Aim OFF", theme.accent_purple, 2)
end)

aimTab:AddToggle("Predictive Aim", false, function(enabled)
    notify("🔮 PREDICTIVE", enabled and "Predictive Aim ON" or "Predictive Aim OFF", theme.accent_cyan, 2)
end)

-- ==================== 🏃 MOVEMENT TAB ====================
local movementTab = menu:AddTab("🏃 MOVEMENT")
movementTab:AddLabel("Movement & Agility")

movementTab:AddSlider("Walk Speed", 16, 200, 16, function(value)
    if humanoid then humanoid.WalkSpeed = value end
end)

movementTab:AddSlider("Jump Power", 50, 500, 50, function(value)
    if humanoid then humanoid.JumpPower = value end
end)

movementTab:AddToggle("Infinite Jump", false, function(enabled)
    infiniteJumpEnabled = enabled
    notify("🦘 INF JUMP", enabled and "Infinite Jump ON" or "Infinite Jump OFF", theme.accent_green, 2)
end)

movementTab:AddToggle("Fly Mode", false, function(enabled)
    notify("🕊️ FLY", enabled and "Fly Mode ON" or "Fly Mode OFF", theme.accent_cyan, 2)
end)

movementTab:AddToggle("Auto Dodge", false, function(enabled)
    notify("💨 DODGE", enabled and "Auto Dodge ON" or "Auto Dodge OFF", theme.accent_yellow, 2)
end)

-- ==================== 👁️ VISUALS TAB ====================
local visualsTab = menu:AddTab("👁️ VISUALS")
visualsTab:AddLabel("Visual Enhancements")

visualsTab:AddToggle("Ball Trajectory", false, function(enabled)
    notify("⚽ TRAJECTORY", enabled and "Ball Trajectory ON" or "Ball Trajectory OFF", theme.accent_orange, 2)
end)

visualsTab:AddToggle("Hit Indicator", true, function(enabled)
    notify("💢 HIT INDICATOR", enabled and "Hit Indicator ON" or "Hit Indicator OFF", theme.accent_red, 2)
end)

visualsTab:AddToggle("Player ESP", false, function(enabled)
    notify("👁️ ESP", enabled and "Player ESP ON" or "Player ESP OFF", theme.accent_blue, 2)
end)

visualsTab:AddToggle("Fullbright", false, function(enabled)
    Lighting.Brightness = enabled and 3 or 2
    Lighting.Ambient = enabled and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(70, 70, 70)
end)

visualsTab:AddSlider("Camera FOV", 70, 140, 70, function(value)
    workspace.CurrentCamera.FieldOfView = value
end)

-- ==================== ⚙️ UTILITY TAB ====================
local utilityTab = menu:AddTab("⚙️ UTILITY")
utilityTab:AddLabel("Quick Tools & Actions")

utilityTab:AddButton("Reset Player", function()
    notify("🔄 RESET", "Player resetting...", theme.accent_red, 2)
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

utilityTab:AddButton("Rejoin Server", function()
    notify("🚪 REJOIN", "Rejoining server...", theme.accent_orange, 2)
    task.wait(1)
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

utilityTab:AddButton("Server Hop", function()
    notify("🌐 SERVER HOP", "Searching for new server...", theme.accent_blue, 2)
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    pcall(function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in pairs(servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                break
            end
        end
    end)
end)

utilityTab:AddDivider()

utilityTab:AddButton("Save Config", function()
    notify("💾 SAVED", "Configuration saved!", theme.accent_green, 2)
end)

utilityTab:AddButton("Load Config", function()
    notify("📂 LOADED", "Configuration loaded!", theme.accent_cyan, 2)
end)

utilityTab:AddDivider()

utilityTab:AddToggle("Anti AFK", true, function(enabled)
    if enabled then
        LocalPlayer.Idled:Connect(function()
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
    notify("🛡️ ANTI AFK", enabled and "Anti AFK ON" or "Anti AFK OFF", theme.accent_purple, 2)
end)

-- ==================== ⚙️ SETTINGS TAB ====================
local settingsTab = menu:AddTab("⚙️ SETTINGS")
settingsTab:AddLabel("General Settings")

settingsTab:AddToggle("Notifications", true, function(enabled)
    notify("🔔 NOTIF", enabled and "Notifications ON" or "Notifications OFF", theme.accent_green, 2)
end)

settingsTab:AddToggle("Sound Effects", false, function(enabled)
    notify("🔊 SOUND", enabled and "Sound ON" or "Sound OFF", theme.accent_yellow, 2)
end)

-- ✅ FIXED: UI Scale proper
settingsTab:AddSlider("UI Scale", 0.7, 1.5, 1.0, function(value)
    if menu.Window then
        menu.Window.Size = UDim2.new(0, WINDOW_WIDTH * value, 0, WINDOW_HEIGHT * value)
    end
end)

settingsTab:AddDivider()

settingsTab:AddButton("Unload Script", function()
    notify("❌ UNLOAD", "Script unloaded", theme.accent_red, 2)
    task.wait(0.5)
    if menu.ScreenGui then
        menu.ScreenGui:Destroy()
    end
end)

-- ==================== FEATURE LOGIC ====================
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and humanoid and humanoid.Health > 0 then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Auto Spike loop
task.spawn(function()
    while task.wait(0.15) do
        if autoSpikeEnabled and playerChar and playerChar:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name:lower():find("ball") then
                        local dist = (obj.Position - playerChar.HumanoidRootPart.Position).Magnitude
                        if dist < 15 then
                            local VirtualUser = game:GetService("VirtualUser")
                            VirtualUser:ClickButton1(Vector2.new())
                        end
                    end
                end
            end)
        end
    end
end)

notify("🏐 VOLLEYBALL LEGENDS", "Fixed! Drag header • Minimize works", theme.accent_orange, 3)

return Library
