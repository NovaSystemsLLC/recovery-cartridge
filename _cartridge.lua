require "Wherigo"
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player

local cartridge = Wherigo.ZCartridge()

cartridge.MsgBoxCBFuncs = {}

-- Media Definitions --


-- Cartridge Info --
cartridge.Id = "305e2634-214d-4f9f-8f74-aca89a588948"
cartridge.Name = "Nova Systems Recovery Cartridge"
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
local zone = Wherigo.Zone(cartridge)
zone.Id = "39c8d039-0772-42fc-9850-d67019b6d743"
zone.Name = "Nova Systems HQ"
zone.Description = [[]]
zone.Visible = false
zone.DistanceRange = Distance(-1, "feet")
zone.ShowObjects = "OnEnter"
zone.ProximityRange = Distance(25, "feet")
zone.AllowSetPositionTo = true
zone.Active = false
zone.Points = {
    ZonePoint(-50, 50),
    ZonePoint(50, 50),
    ZonePoint(50, -50),
    ZonePoint(-50, -50)
}
zone.OriginalPoint = ZonePoint(0, 0)
zone.DistanceRangeUOM = "Feet"
zone.ProximityRangeUOM = "Feet"
zone.OutOfRangeName = ""
zone.InRangeName = ""

function cartridge:OnStart()

end

return cartridge