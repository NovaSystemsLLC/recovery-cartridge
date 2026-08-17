require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player

local cartridge = Wherigo.ZCartridge()

-- Media Definitions --

-- Cartridge Info --
cartridge.Id = "305e2634-214d-4f9f-8f74-aca89a588948"
cartridge.Name = "Nova Systems Recovery"
cartridge.Description = "It's a recovery cartridge. You need a code from a machine to use it."
cartridge.Visible = true
cartridge.Activity = "Puzzle"
cartridge.StartingLocationDescription = ""
cartridge.StartingLocation = Wherigo.INVALID_ZONEPOINT
cartridge.Version = "1.0"
cartridge.Company = "Nova Systems"
cartridge.Author = "Nova Systems"
cartridge.BuilderVersion = ""
cartridge.CreateDate = "1/1/1970 12:00:00 AM"
cartridge.PublishDate = "1/1/1970 12:00:00 AM"
cartridge.UpdateDate = "1/1/1970 12:00:00 AM"
cartridge.LastPlayedDate = "1/1/1970 12:00:00 AM"
cartridge.TargetDevice = "PocketPC"
cartridge.TargetDeviceVersion = "0"
cartridge.StateId = "1"
cartridge.CountryId = "2"
cartridge.Complete = false
cartridge.UseLogging = true

-- Zone Definitions --
local startZone = Wherigo.Zone(cartridge)
startZone.Id = "39c8d039-0772-42fc-9850-d67019b6d743"
startZone.Name = "Nova Systems HQ: Holding Centre"
startZone.Description = [[A holding room. You woke up here, with no memory of yourself.]]
startZone.Visible = false
startZone.DistanceRange = Distance(-1, "feet")
startZone.ShowObjects = "Always"
startZone.ProximityRange = Distance(25, "feet")
startZone.AllowSetPositionTo = true
startZone.Active = false
startZone.Points = {
	ZonePoint(-50, 50),
	ZonePoint(50, 50),
	ZonePoint(50, -50),
	ZonePoint(-50, -50),
}
startZone.OriginalPoint = ZonePoint(0, 0)
startZone.DistanceRangeUOM = "Feet"
startZone.ProximityRangeUOM = "Feet"
startZone.OutOfRangeName = ""
startZone.InRangeName = ""

local securityRoom = Wherigo.Zone(cartridge)
securityRoom.Id = "0787a9be-87f0-422b-8adc-e98e56fca3ee"
securityRoom.Name = "Nova Systems HQ: Security Room"
securityRoom.Description = [[A security room. It looks almost abandoned. There's monitors showing camera feeds.]]
securityRoom.Visible = false
securityRoom.DistanceRange = Distance(-1, "feet")
securityRoom.ShowObjects = "Always"
securityRoom.ProximityRange = Distance(25, "feet")
securityRoom.AllowSetPositionTo = true
securityRoom.Active = false
securityRoom.Points = {
	ZonePoint(-50, 50),
	ZonePoint(50, 50),
	ZonePoint(50, -50),
	ZonePoint(-50, -50),
}
securityRoom.OriginalPoint = ZonePoint(0, 0)
securityRoom.DistanceRangeUOM = "Feet"
securityRoom.ProximityRangeUOM = "Feet"
securityRoom.OutOfRangeName = ""
securityRoom.InRangeName = ""

-- Input definitions --
local errCodeInput = Wherigo.ZInput(cartridge)
errCodeInput.Id = "cc406393-332a-48ea-a1cb-6866d546b24e"
errCodeInput.Name = "Error Code"
errCodeInput.Description = [[]]
errCodeInput.Visible = true
errCodeInput.InputType = "Text"
errCodeInput.InputVariableId = "c2002b8d-9fdb-4b7b-b98d-600971d5aac7"
errCodeInput.Text = "Please enter the error code that you're seeing on the machine."

-- Item definitions --
local accessKey = Wherigo.ZItem({
	Cartridge = cartridge,
})
accessKey.Id = "bad0443a-873b-4a58-966c-79c8722cbd21"
accessKey.Name = "Access Card"
accessKey.Description = [[A Nova Systems keycard. The front is defaced, so you can't identify the owner.
The printed identifier on the back reads: NS-7A-041.]]
accessKey.Visible = true
accessKey.Icon = nil
accessKey.Commands = {}
accessKey.Locked = false
accessKey.ObjectLocation = Wherigo.INVALID_ZONEPOINT

local startingRoomTerminal = Wherigo.ZItem({
	Cartridge = cartridge,
	Container = startZone,
})
startingRoomTerminal.Id = "70654205-2c84-47f8-8c64-34bc363894b8"
startingRoomTerminal.Name = "Terminal"
startingRoomTerminal.Description = [[It's a computer terminal. On the side is a scanner of sorts.]]
startingRoomTerminal.Visible = true
startingRoomTerminal.Icon = nil
startingRoomTerminal.Commands = {
	Scan = Wherigo.ZCommand({
		Text = "Scan",
		CmdWith = false,
		Enabled = true,
		EmptyTargetListText = "Nothing useful.",
	}),
	Use = Wherigo.ZCommand({
		Text = "Use",
		CmdWith = false,
		Enabled = true,
		EmptyTargetListText = "Nothing useful.",
	}),
}
startingRoomTerminal.Commands["Scan"].Custom = true
startingRoomTerminal.Commands["Scan"].Id = "2a16d026-3535-4d0f-80f1-0eefc716a026"
startingRoomTerminal.Commands["Scan"].WorksWithAll = true
startingRoomTerminal.Commands["Use"].Custom = true
startingRoomTerminal.Commands["Use"].Id = "065c2f92-ac0f-49fc-873e-ef44a6dbb87c"
startingRoomTerminal.Commands["Use"].WorksWithAll = true
startingRoomTerminal.Locked = false
startingRoomTerminal.ObjectLocation = Wherigo.INVALID_ZONEPOINT

local startingRoomDrawer = Wherigo.ZItem({
	Cartridge = cartridge,
	Container = startZone,
})
startingRoomDrawer.Id = "5942eba0-eefb-4443-a878-8811d64ebc83"
startingRoomDrawer.Name = "Side Drawer"
startingRoomDrawer.Description = [[There's an access card in here, as well as a locked safe.]]
startingRoomDrawer.Visible = true
startingRoomDrawer.Icon = nil
startingRoomDrawer.Commands = {
	TakeCard = Wherigo.ZCommand({
		Text = "Take Card",
		CmdWith = false,
		Enabled = true,
		EmptyTargetListText = "Nothing useful.",
	}),
	TakeSafe = Wherigo.ZCommand({
		Text = "Take Safe",
		CmdWith = false,
		Enabled = true,
		EmptyTargetListText = "Nothing useful.",
	}),
}
startingRoomDrawer.Commands["TakeCard"].Custom = true
startingRoomDrawer.Commands["TakeCard"].Id = "8cf4f1fc-dd7d-4171-8ca2-4abc11983463"
startingRoomDrawer.Commands["TakeCard"].WorksWithAll = true
startingRoomDrawer.Commands["TakeSafe"].Custom = true
startingRoomDrawer.Commands["TakeSafe"].Id = "b8a4aace-873b-4f10-8cdc-f64afcd71e32"
startingRoomDrawer.Commands["TakeSafe"].WorksWithAll = true
startingRoomDrawer.Locked = false
startingRoomDrawer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
accessKey:MoveTo(startingRoomDrawer)

local startingRoomSafe = Wherigo.ZItem({
	Cartridge = cartridge,
	Container = startingRoomDrawer,
})
startingRoomSafe.Id = "bff0074f-abbe-471a-98ae-66161aa30a8b"
startingRoomSafe.Name = "Safe"
startingRoomSafe.Description = [[It's a heavy-duty safe. There's a combination lock on the side. ]]
startingRoomSafe.Visible = true
startingRoomSafe.Icon = nil
startingRoomSafe.Commands = {
	Unlock = Wherigo.ZCommand({
		Text = "Unlock",
		CmdWith = false,
		Enabled = true,
		EmptyTargetListText = "Nothing available.",
	}),
}
startingRoomSafe.Commands["Unlock"].Custom = true
startingRoomSafe.Commands["Unlock"].Id = "a2eaf336-06fd-4f87-81a8-43fb949940a2"
startingRoomSafe.Commands["Unlock"].WorksWithAll = true
startingRoomSafe.Locked = false
startingRoomSafe.ObjectLocation = Wherigo.INVALID_ZONEPOINT

local startingRoomDoor = Wherigo.ZItem({
	Cartridge = cartridge,
	Container = startZone,
})
startingRoomDoor.Id = "071b0a02-a9de-49bd-ac66-3c9c12b015cc"
startingRoomDoor.Name = "Access Door"
startingRoomDoor.Description = [[It's a door protected by a card scanner.]]
startingRoomDoor.Visible = true
startingRoomDoor.Icon = nil
startingRoomDoor.Commands = {
	Open = Wherigo.ZCommand({
		Text = "Open",
		CmdWith = false,
		Enabled = true,
		EmptyTargetListText = "Nothing available.",
	}),
}
startingRoomDoor.Commands["Open"].Custom = true
startingRoomDoor.Commands["Open"].Id = "360fa55b-2b41-4d31-bd82-366f03723269"
startingRoomDoor.Commands["Open"].WorksWithAll = true
startingRoomDoor.Locked = false
startingRoomDoor.ObjectLocation = Wherigo.INVALID_ZONEPOINT

-- Variables --
local errCode = nil
local err = { 0x4e, 0x53, 0x52, 0x43, 0x2d, 0x34, 0x37, 0x33, 0x38 }

local function check(s, a)
	if #s ~= #a then
		return false
	end

	for i = 1, #a do
		if string.byte(s, i) ~= a[i] then
			return false
		end
	end

	return true
end

local function SetRoomPoints(room, pos)
	local halfSide = 50
	local cornerDistance = math.sqrt(2 * halfSide ^ 2)

	room.Points = {
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 45),
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 135),
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 225),
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 315),
	}
end

local currentRoom = nil

local function MoveToRoom(room)
	if currentRoom then
		currentRoom.Active = false
		currentRoom.Visible = false
	end

	currentRoom = room
	currentRoom.Active = true
	currentRoom.Visible = true
end

local startTerminalUnlocked = false
local keyOutOfDrawer = false
local safeOutOfDrawer = false

-- Cartridge functions --
function cartridge:OnStart()
	local pos = Player.ObjectLocation

	SetRoomPoints(startZone, pos)
	SetRoomPoints(securityRoom, pos)

	Wherigo.GetInput(errCodeInput)
end

function errCodeInput:OnGetInput(input)
	errCode = input

	if not check(errCode, err) then
		Wherigo.MessageBox({
			Text = "This isn't a valid NSRC error code. Please reboot the cartridge to try again.",
			Buttons = { "Exit" },
			Callback = function(action)
				if action ~= nil then
					Wherigo.ShowScreen(Wherigo.MAINSCREEN)
				end
			end,
		})
	else
		MoveToRoom(startZone)

		Wherigo.MessageBox({
			Text = "Identified NSRC error code. Recovery protocol initiated.",
			Buttons = { "Continue" },
			Callback = function(action)
				if action ~= nil then
					Wherigo.ShowScreen(Wherigo.MAINSCREEN)
				end
			end,
		})
	end
end

function startingRoomTerminal:OnScan()
	if not Player:Contains(accessKey) then
		Wherigo.ShowStatusText("You don't have anything that you can scan here.")
		return
	end

	startTerminalUnlocked = true
	startingRoomTerminal.Commands["Scan"].Enabled = false
	Wherigo.MessageBox({
		Text = "The terminal screen lights up a warm glow.",
		Buttons = { "OK" },
		Callback = function() end,
	})
end

function startingRoomTerminal:OnUse()
	if not startTerminalUnlocked then
		Wherigo.ShowStatusText("It doesn't seem to be working.")
		return
	end

	-- TODO: impl terminal
	Wherigo.ShowStatusText("Not implemented")
end

function startingRoomDrawer:OnTakeCard()
	accessKey:MoveTo(Player)
	startingRoomDrawer.Commands["TakeCard"].Enabled = false
	Wherigo.ShowStatusText("Access Card has been moved to your inventory.")

	keyOutOfDrawer = true
	if safeOutOfDrawer then
		Wherigo.ShowScreen(Wherigo.MAINSCREEN)
		startingRoomDrawer.Visible = false
	else
		startingRoomDrawer.Description = [[There's a locked safe in here.]]
	end
end

function startingRoomDrawer:OnTakeSafe()
	startingRoomSafe:MoveTo(startZone)
	startingRoomDrawer.Commands["TakeSafe"].Enabled = false
	Wherigo.ShowStatusText("The safe has been removed from the side drawer.")

	safeOutOfDrawer = true
	if keyOutOfDrawer then
		Wherigo.ShowScreen(Wherigo.MAINSCREEN)
		startingRoomDrawer.Visible = false
	else
		startingRoomDrawer.Description = [[There's an access card in here.]]
	end
end

function startingRoomSafe:OnUnlock()
	-- TODO: impl safe
	Wherigo.ShowStatusText("Not implemented")
end

function startingRoomDoor:OnOpen()
	if not Player:Contains(accessKey) then
		Wherigo.ShowStatusText("You don't have anything that can open this door.")
		return
	end

	Wherigo.ShowStatusText("Click!")
	Wherigo.ShowScreen(Wherigo.MAINSCREEN)

	if currentRoom == startZone then
		startingRoomDoor.Name = "Door to Holding Centre"
		startingRoomDoor.Description = [[It's a door protected by a card scanner.
It leads to the Nova Systems Holding Centre.]]
		MoveToRoom(securityRoom)
	else
		startingRoomDoor.Name = "Door to Security Room"
		startingRoomDoor.Description = [[It's a door protected by a card scanner.
It leads to the Nova Systems Security Room.]]
		MoveToRoom(startZone)
	end

	startingRoomDoor:MoveTo(currentRoom)
end

return cartridge
