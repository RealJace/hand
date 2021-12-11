
--https://github.com/Mokiros/roblox-FE-compatibility
if game:GetService("RunService"):IsClient() then error("Script must be server-side in order to work; use h/ and not hl/") end
local Player,game,owner = owner,game
local RealPlayer = Player
do
	print("FE Compatibility code V2 by Mokiros")
	local RealPlayer = RealPlayer
	script.Parent = RealPlayer.Character

	--Fake event to make stuff like Mouse.KeyDown work
	local Disconnect_Function = function(this)
		this[1].Functions[this[2]] = nil
	end
	local Disconnect_Metatable = {__index={disconnect=Disconnect_Function,Disconnect=Disconnect_Function}}
	local FakeEvent_Metatable = {__index={
		Connect = function(this,f)
			local i = tostring(math.random(0,10000))
			while this.Functions[i] do
				i = tostring(math.random(0,10000))
			end
			this.Functions[i] = f
			return setmetatable({this,i},Disconnect_Metatable)
		end
	}}
	FakeEvent_Metatable.__index.connect = FakeEvent_Metatable.__index.Connect
	local function fakeEvent()
		return setmetatable({Functions={}},FakeEvent_Metatable)
	end

	--Creating fake input objects with fake variables
	local FakeMouse = {Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent(),Button2Up=fakeEvent(),Button2Down=fakeEvent()}
	FakeMouse.keyUp = FakeMouse.KeyUp
	FakeMouse.keyDown = FakeMouse.KeyDown
	local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
	local CAS = {Actions={},BindAction=function(self,name,fun,touch,...)
		CAS.Actions[name] = fun and {Name=name,Function=fun,Keys={...}} or nil
	end}
	--Merged 2 functions into one by checking amount of arguments
	CAS.UnbindAction = CAS.BindAction

	--This function will trigger the events that have been :Connect()'ed
	local function TriggerEvent(self,ev,...)
		for _,f in pairs(self[ev].Functions) do
			f(...)
		end
	end
	FakeMouse.TriggerEvent = TriggerEvent
	UIS.TriggerEvent = TriggerEvent

	--Client communication
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInput_Event"
	Event.OnServerEvent:Connect(function(plr,io)
		if plr~=RealPlayer then return end
		FakeMouse.Target = io.Target
		FakeMouse.Hit = io.Hit
		if not io.isMouse then
			local b = io.UserInputState == Enum.UserInputState.Begin
			if io.UserInputType == Enum.UserInputType.MouseButton1 then
				return FakeMouse:TriggerEvent(b and "Button1Down" or "Button1Up")
			end
			if io.UserInputType == Enum.UserInputType.MouseButton2 then
				return FakeMouse:TriggerEvent(b and "Button2Down" or "Button2Up")
			end
			for _,t in pairs(CAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			FakeMouse:TriggerEvent(b and "KeyDown" or "KeyUp",io.KeyCode.Name:lower())
			UIS:TriggerEvent(b and "InputBegan" or "InputEnded",io,false)
		end
	end)
	Event.Parent = NLS([==[local Event = script:WaitForChild("UserInput_Event")
	local Mouse = owner:GetMouse()
	local UIS = game:GetService("UserInputService")
	local input = function(io,RobloxHandled)
		if RobloxHandled then return end
		--Since InputObject is a client-side instance, we create and pass table instead
		Event:FireServer({KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState,Hit=Mouse.Hit,Target=Mouse.Target})
	end
	UIS.InputBegan:Connect(input)
	UIS.InputEnded:Connect(input)

	local h,t
	--Give the server mouse data every second frame, but only if the values changed
	--If player is not moving their mouse, client won't fire events
	local HB = game:GetService("RunService").Heartbeat
	while true do
		if h~=Mouse.Hit or t~=Mouse.Target then
			h,t=Mouse.Hit,Mouse.Target
			Event:FireServer({isMouse=true,Target=t,Hit=h})
		end
		--Wait 2 frames
		for i=1,2 do
			HB:Wait()
		end
	end]==],script)

	----Sandboxed game object that allows the usage of client-side methods and services
	--Real game object
	local RealGame = game

	--Metatable for fake service
	local FakeService_Metatable = {
		__index = function(self,k)
			local s = rawget(self,"_RealService")
			if s then
				return typeof(s[k])=="function"
					and function(_,...)return s[k](s,...)end or s[k]
			end
		end,
		__newindex = function(self,k,v)
			local s = rawget(self,"_RealService")
			if s then s[k]=v end
		end
	}
	local function FakeService(t,RealService)
		t._RealService = typeof(RealService)=="string" and RealGame:GetService(RealService) or RealService
		return setmetatable(t,FakeService_Metatable)
	end

	--Fake game object
	local FakeGame = {
		GetService = function(self,s)
			return rawget(self,s) or RealGame:GetService(s)
		end,
		Players = FakeService({
			LocalPlayer = FakeService({GetMouse=function(self)return FakeMouse end},Player)
		},"Players"),
		UserInputService = FakeService(UIS,"UserInputService"),
		ContextActionService = FakeService(CAS,"ContextActionService"),
		RunService = FakeService({
			_btrs = {},
			RenderStepped = RealGame:GetService("RunService").Heartbeat,
			BindToRenderStep = function(self,name,_,fun)
				self._btrs[name] = self.Heartbeat:Connect(fun)
			end,
			UnbindFromRenderStep = function(self,name)
				self._btrs[name]:Disconnect()
			end,
		},"RunService")
	}
	rawset(FakeGame.Players,"localPlayer",FakeGame.Players.LocalPlayer)
	FakeGame.service = FakeGame.GetService
	FakeService(FakeGame,game)
	--Changing owner to fake player object to support owner:GetMouse()
	game,owner = FakeGame,FakeGame.Players.LocalPlayer
end

local char = owner.Character or owner.CharacterAdded:Wait()

local hum = char:FindFirstChildWhichIsA("Humanoid")

if hum.RigType == Enum.HumanoidRigType.R15 then --Github this line !!!!!1!111!!!!
	error("This script only supports R6, change your rig type to R6 and run this script again.") 
else
	print("Script loaded succesfully, enjoy!")
end

local mouse = owner:GetMouse()
local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:WaitForChild("HumanoidRootPart")
local currentTarget = nil

hum.MaxHealth = math.huge
hum.Health = hum.MaxHealth

local Hand = Instance.new("Part")
local Offset = Vector3.new(0,2,0)
local SpecialMesh1 = Instance.new("SpecialMesh")
Hand.Name = "Hand"
Hand.Parent = char
Hand.BrickColor = char["Right Arm"].BrickColor
Hand.Size = Vector3.new(4,4,2)
Hand.Anchored = true
Hand.CanCollide = false
Hand.CanQuery = false
Hand.CanTouch = false
Hand.BrickColor = BrickColor.new("Institutional white")
Hand.Material = Enum.Material.Slate
Hand.brickColor = BrickColor.new("Institutional white")
Hand.FormFactor = Enum.FormFactor.Plate
Hand.formFactor = Enum.FormFactor.Plate
SpecialMesh1.Parent = Hand
SpecialMesh1.MeshId = "http://www.roblox.com/asset/?id=32054761"
SpecialMesh1.MeshType = Enum.MeshType.FileMesh

coroutine.wrap(function()
	while true do
		Hand.CFrame = Hand.CFrame:Lerp(CFrame.new(mouse.Hit.Position + Offset) * CFrame.lookAt(hrp.Position,mouse.Hit.Position).Rotation * CFrame.Angles(0,0,math.rad(180)),0.3)
		game:GetService("RunService").Stepped:Wait()
	end
end)()

mouse.Button1Down:Connect(function()
	if mouse.Target then
		local model = mouse.Target:FindFirstAncestorWhichIsA("Model")
		if model and model ~= char and currentTarget == nil then
			local targetHrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("Head")
			if targetHrp then
				for _,i in pairs(model:GetDescendants()) do
					if i:IsA("BasePart") then
						if not i:FindFirstChild("HandNoCollision") then
							for _,x in pairs(char:GetDescendants()) do
								if x:IsA("BasePart") then
									local ncc2 = Instance.new("NoCollisionConstraint",i)
									ncc2.Part0 = i
									ncc2.Part1 = x
									ncc2.Name = "HandNoCollision"
								end
							end
						end
					end
				end
				mouse.TargetFilter = model
				currentTarget = model
				targetHrp.Anchored = false
				local weld = Instance.new("Weld",Hand)
				weld.Part0 = Hand
				weld.Part1 = targetHrp
				weld.C0 = CFrame.new(0,0,-1) * CFrame.Angles(0,0,math.rad(180))
			end
		end
	end
end)

hum.StateChanged:Connect(function(old,new)
	if hum.Health > 0 then
		if new == Enum.HumanoidStateType.Seated or new == Enum.HumanoidStateType.PlatformStanding or old == Enum.HumanoidStateType.Seated or old == Enum.HumanoidStateType.PlatformStanding then
			hum.PlatformStand = false
			hum.Sit = false
			hum.Jump = true
			print("anti platform and sit has been triggered")
		end
	end
end)

mouse.KeyDown:Connect(function(key)
	if key == "q" then
		if currentTarget ~= nil then
			local weld = Hand:FindFirstChildWhichIsA("Weld")
			if weld then
				weld:Destroy()
			end
			for _,i in pairs(currentTarget:GetDescendants()) do
				if i:IsA("NoCollisionConstraint") and i.Name == "HandNoCollision" then
					i:Destroy()
				end
			end
			mouse.TargetFilter = nil
			local hum = currentTarget:FindFirstChildWhichIsA("Humanoid")
			if hum then
				hum.PlatformStand = false
				hum.Jump = true
			end
			currentTarget = nil
		else
			local weld = Hand:FindFirstChildWhichIsA("Weld")
			if weld then
				weld:Destroy()
			end
			mouse.TargetFilter = nil
		end
	end
end)
