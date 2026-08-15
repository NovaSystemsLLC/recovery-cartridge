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
local hqZone = Wherigo.Zone(cartridge)
hqZone.Id = "39c8d039-0772-42fc-9850-d67019b6d743"
hqZone.Name = "Nova Systems HQ"
hqZone.Description = [[]]
hqZone.Visible = false
hqZone.DistanceRange = Distance(-1, "feet")
hqZone.ShowObjects = "OnEnter"
hqZone.ProximityRange = Distance(25, "feet")
hqZone.AllowSetPositionTo = true
hqZone.Active = false
hqZone.Points = {
	ZonePoint(-50, 50),
	ZonePoint(50, 50),
	ZonePoint(50, -50),
	ZonePoint(-50, -50),
}
hqZone.OriginalPoint = ZonePoint(0, 0)
hqZone.DistanceRangeUOM = "Feet"
hqZone.ProximityRangeUOM = "Feet"
hqZone.OutOfRangeName = ""
hqZone.InRangeName = ""

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
local accessKey = Wherigo.ZItem(cartridge)
accessKey.Id = ""
accessKey.Name = "Access Card"
accessKey.Description = [[A Nova Systems keycard. The front is defaced, so you can't identify the owner.

The printed identifier on the back reads: NS-7A-041.]]
accessKey.Visible = false
accessKey.Icon = nil
accessKey.Commands = {
	Take = Wherigo.ZCommand({
		Text = "Take",
		CmdWith = false,
		Enabled = false,
		EmptyTargetListText = "Nothing available.",
	}),
}
accessKey.Commands["Take"].Custom = true
accessKey.Commands["Take"].Id = "66a5f906-3c8f-4731-a4e9-3c21df9dc36a"
accessKey.Commands["Take"].WorksWithAll = true
accessKey.Locked = false
accessKey.ObjectLocation = Wherigo.INVALID_ZONEPOINT

-- Variables --
local errCode = nil
local a = { 0x4e, 0x53, 0x52, 0x43, 0x2d, 0x34, 0x37, 0x33, 0x38 }

local function check(s)
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

-- Cartridge functions --
function cartridge:OnStart()
	local pos = Player.ObjectLocation
	local halfSide = 50
	local cornerDistance = math.sqrt(halfSide ^ 2 + halfSide ^ 2)

	hqZone.Points = {
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 45),
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 135),
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 225),
		Wherigo.TranslatePoint(pos, Distance(cornerDistance, "feet"), 315),
	}

	Wherigo.GetInput(errCodeInput)
end

function errCodeInput:OnGetInput(input)
	errCode = input

	if not check(errCode) then
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
		hqZone.Active = true
		accessKey.Visible = true
		accessKey.Commands["Take"].Enabled = true
		accessKey:MoveTo(hqZone)
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

function accessKey:OnTake()
	accessKey:MoveTo(Player)
	accessKey.Commands["Take"].Enabled = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end

return cartridge