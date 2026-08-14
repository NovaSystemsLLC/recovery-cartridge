---@meta
--- IntelliSense/LuaLS stub for Jakuje/webwig's Wherigo runtime.
--- Source: https://github.com/Jakuje/webwig/blob/master/wherigo.lua
--- This file intentionally contains declarations only; it is not the runtime implementation.

---@alias WherigoScreen
---| "main"
---| "inventory"
---| "youSee"
---| "locations"
---| "tasks"
---| "detail"

---@alias WherigoLogLevel integer
---@alias WherigoZoneState
---| "NotInRange"
---| "Distant"
---| "Proximity"
---| "Inside"

---@class WherigoChoiceMap: table<string|integer, string>
---@class WherigoResource
---@field Type string
---@field Filename? string
---@field Filname? string
---@field Directives? table

---@class Wherigo
Wherigo = {}

-- Constants
Wherigo.INVALID_ZONEPOINT = nil
Wherigo.MAINSCREEN = "main"
Wherigo.INVENTORYSCREEN = "inventory"
Wherigo.ITEMSCREEN = "youSee"
Wherigo.LOCATIONSCREEN = "locations"
Wherigo.TASKSCREEN = "tasks"
Wherigo.DETAILSCREEN = "detail"
Wherigo.LOGDEBUG = 150
Wherigo.LOGCARTRIDGE = 151
Wherigo.LOGINFO = 152
Wherigo.LOGWARNING = 153
Wherigo.LOGERROR = 154
Wherigo.CLASS_ZONE = "Zone"
Wherigo.CLASS_ZMEDIA = "ZMedia"
Wherigo.CLASS_ZCARTRIDGE = "ZCartridge"
Wherigo.CLASS_ZCHARACTER = "ZCharacter"
Wherigo.CLASS_ZCOMMAND = "ZCommand"
Wherigo.CLASS_ZINPUT = "ZInput"
Wherigo.CLASS_ZTASK = "ZTask"
Wherigo.CLASS_ZITEM = "ZItem"
Wherigo.CLASS_ZTIMER = "ZTimer"
Wherigo.CLASS_DISTANCE = "Distance"
Wherigo.CLASS_BEARING = "Bearing"
Wherigo.CLASS_ZONEPOINT = "ZonePoint"
Wherigo.CLASS_ZRECIPROCALCOMMAND = "ZReciprocalCommand"
Wherigo.CLASS_ZOBJECT = "ZObject"

---Show a message box.
---@param t WherigoMessageBoxParams
---@return nil
function Wherigo.MessageBox(t) end

---@class WherigoMessageBoxParams
---@field Text string
---@field Media? Wherigo.ZMedia
---@field Buttons? string[]
---@field Callback? fun(action: string|nil)

---Show a series of message boxes.
---@param t table|WherigoMessageBoxParams[]
---@return nil
function Wherigo.Dialog(t) end

---Play a media object as audio.
---@param Media Wherigo.ZMedia
---@return nil
function Wherigo.PlayAudio(Media) end

---Show status text in the player UI.
---@param Text string
---@return nil
function Wherigo.ShowStatusText(Text) end

---Calculate distance and bearing from a point to the nearest point of a zone.
---@param point Wherigo.ZonePoint
---@param zone Wherigo.Zone
---@return Wherigo.Distance distance
---@return Wherigo.Bearing bearing
function Wherigo.VectorToZone(point, zone) end

---Calculate distance and bearing from a point to the nearest point of a segment.
---@param point Wherigo.ZonePoint
---@param p1 Wherigo.ZonePoint
---@param p2 Wherigo.ZonePoint
---@return Wherigo.Distance distance
---@return Wherigo.Bearing bearing
function Wherigo.VectorToSegment(point, p1, p2) end

---Determine whether a point is inside a zone.
---@param point Wherigo.ZonePoint
---@param zone Wherigo.Zone
---@return boolean
function Wherigo.IsPointInZone(point, zone) end

---Legacy point-in-zone implementation.
---@param point Wherigo.ZonePoint
---@param zone Wherigo.Zone
---@return boolean
function Wherigo.IsPointInZoneOld(point, zone) end

---Translate a point by a distance and bearing.
---@param point Wherigo.ZonePoint
---@param distance Wherigo.Distance
---@param bearing Wherigo.Bearing|number
---@return Wherigo.ZonePoint
function Wherigo.TranslatePoint(point, distance, bearing) end

---Calculate distance and bearing between two points.
---@param p1 Wherigo.ZonePoint
---@param p2 Wherigo.ZonePoint
---@return Wherigo.Distance distance
---@return Wherigo.Bearing bearing
function Wherigo.VectorToPoint(p1, p2) end

---Case-insensitive string comparison.
---@param f string
---@param s string
---@return boolean
function Wherigo.NoCaseEquals(f, s) end

---Send a command to the Wherigo engine.
---@param text string
---@return nil
function Wherigo.Command(text) end

---Write a message to the cartridge log.
---@param Text string|{Text:string, Level?:WherigoLogLevel}
---@param Level? WherigoLogLevel
---@return nil
function Wherigo.LogMessage(Text, Level) end

---Request user input using a ZInput object.
---@param input Wherigo.ZInput
---@return nil
function Wherigo.GetInput(input) end

---Show one of the standard Wherigo screens.
---@param screen WherigoScreen
---@param item? Wherigo.ZObject
---@return nil
function Wherigo.ShowScreen(screen, item) end

---Convert a Wherigo distance/bearing object to its numeric value.
---@param arg number|Wherigo.Distance|Wherigo.Bearing
---@return number
function Wherigo.__tonumber(arg) end

-- ============================================================================
-- Value types
-- ============================================================================

---@class Wherigo.Bearing
---@field value number Bearing in degrees, normalized to 0..360.
---@field _classname string
Wherigo.Bearing = {}

---@param value? number
---@return Wherigo.Bearing
function Wherigo.Bearing.new(value) end

---@param object any
---@return boolean
function Wherigo.Bearing:made(object) end

---@class Wherigo.Distance
---@field value number Distance in meters.
---@field _classname string
Wherigo.Distance = {}

---@param value number
---@param units? string Units accepted by the runtime: meters/metres/m, kilometres/km, feet/ft, miles/mi, nauticalmiles.
---@return Wherigo.Distance
function Wherigo.Distance.new(value, units) end

---@param units? string|{units:string}
---@return number
function Wherigo.Distance:GetValue(units) end

---@param object any
---@return boolean
function Wherigo.Distance:made(object) end

---@class Wherigo.ZonePoint
---@field latitude number Latitude in degrees.
---@field longitude number Longitude in degrees.
---@field altitude Wherigo.Distance Altitude.
---@field _classname string
Wherigo.ZonePoint = {}

---@param lat number
---@param lon number
---@param alt? number|Wherigo.Distance
---@return Wherigo.ZonePoint
function Wherigo.ZonePoint.new(lat, lon, alt) end

---@param object any
---@return boolean
function Wherigo.ZonePoint:made(object) end

-- ============================================================================
-- Base ZObject and derived game objects
-- ============================================================================

---@class Wherigo.ZObject
---@field Name string
---@field Description string
---@field Id? string|number
---@field ObjIndex integer
---@field Cartridge Wherigo.ZCartridge
---@field Container Wherigo.ZObject|nil
---@field Visible boolean
---@field Active boolean
---@field Locked? boolean
---@field Media Wherigo.ZMedia|false|nil
---@field Icon Wherigo.ZMedia|false|nil
---@field ObjectLocation Wherigo.ZonePoint|nil
---@field Commands table<string|integer, Wherigo.ZCommand>
---@field CommandsArray Wherigo.ZCommand[]
---@field Inventory Wherigo.ZObject[]
---@field _classname string
---@field _enabled? boolean
---@field OnClick? fun(self: Wherigo.ZObject)
---@field OnSetActive? fun(self: Wherigo.ZObject)
Wherigo.ZObject = {}

---@param cartridge? Wherigo.ZCartridge
---@param container? Wherigo.ZObject
---@return Wherigo.ZObject
function Wherigo.ZObject.new(cartridge, container) end

---@param object any
---@return boolean
function Wherigo.ZObject:made(object) end

---Check whether this object contains another object.
---@param obj Wherigo.ZObject|Wherigo.ZCharacter
---@return boolean
function Wherigo.ZObject:Contains(obj) end

---Move this object to another container, or nil.
---@param owner Wherigo.ZObject|nil
---@return nil
function Wherigo.ZObject:MoveTo(owner) end

---@return boolean
function Wherigo.ZObject._is_visible() end

---@param exists? boolean
---@return Wherigo.ZonePoint|nil
function Wherigo.ZObject._get_pos(exists) end

---@class Wherigo.ZCartridge: Wherigo.ZObject
---@field AllZObjects table<integer, Wherigo.ZObject>
---@field AllZCharacters Wherigo.ZCharacter[]
---@field AllZItems Wherigo.ZItem[]
---@field AllZones Wherigo.Zone[]
---@field AllZTimers Wherigo.ZTimer[]
---@field ZVariables table<string, any>
---@field Company string
---@field Activity string
---@field EmptyInventoryListText string
---@field EmptyTasksListText string
---@field EmptyZonesListText string
---@field EmptyYouSeeListText string
---@field Complete boolean
---@field OnStart? fun(self: Wherigo.ZCartridge)
---@field OnSync? fun(self: Wherigo.ZCartridge)
---@field OnComplete? fun(self: Wherigo.ZCartridge)
---@field _mediacount integer
Wherigo.ZCartridge = {}

---@return Wherigo.ZCartridge
function Wherigo.ZCartridge.new() end

---@param object any
---@return boolean
function Wherigo.ZCartridge:made(object) end

---Request a cartridge sync.
---@return nil
function Wherigo.ZCartridge:RequestSync() end

---Get all objects of a supported type.
---@param t "Zone"|"ZItem"|"Timer"|"ZCharacter" string
---@return Wherigo.ZObject[]|nil
function Wherigo.ZCartridge:GetAllOfType(t) end

---@class Wherigo.ZMedia: Wherigo.ZObject
---@field AltText? string
---@field Resources WherigoResource[]
---@field _id number|string
Wherigo.ZMedia = {}

---@param cartridge Wherigo.ZCartridge
---@return Wherigo.ZMedia
function Wherigo.ZMedia.new(cartridge) end

---@param object any
---@return boolean
function Wherigo.ZMedia:made(object) end

---@class Wherigo.ZCommand
---@field Text string
---@field CmdWith boolean
---@field EmptyTargetListText string
---@field MakeReciprocal boolean
---@field WorksWithAll boolean
---@field WorksWithList Wherigo.ZObject[]|false
---@field Custom boolean
---@field ReciprocatedCmds Wherigo.ZReciprocalCommand[]
---@field Enabled boolean
---@field Keyword string|integer
---@field Owner Wherigo.ZObject
---@field Index integer
---@field On? fun(self: Wherigo.ZCommand, target: Wherigo.ZObject|nil)
Wherigo.ZCommand = {}

---@param params? table
---@return Wherigo.ZCommand
function Wherigo.ZCommand.new(params) end

---@param object any
---@return boolean
function Wherigo.ZCommand:made(object) end

---@class Wherigo.ZReciprocalCommand
---@field Text? string
---@field CmdWith? boolean
---@field Owner? Wherigo.ZObject
---@field OriginalCommand? Wherigo.ZCommand
---@field _classname string
Wherigo.ZReciprocalCommand = {}

---@param params? table
---@return Wherigo.ZReciprocalCommand
function Wherigo.ZReciprocalCommand.new(params) end

---@param object any
---@return boolean
function Wherigo.ZReciprocalCommand:made(object) end

---@class Wherigo.Zone: Wherigo.ZObject
---@field Points Wherigo.ZonePoint[]
---@field OriginalPoint Wherigo.ZonePoint|nil
---@field State WherigoZoneState
---@field Inside boolean
---@field CurrentBearing Wherigo.Bearing
---@field CurrentDistance Wherigo.Distance
---@field ShowObjects "OnEnter"|"OnProximity"|"Always"|string
---@field DistanceRange Wherigo.Distance
---@field ProximityRange Wherigo.Distance
---@field ClosestPoint Wherigo.ZonePoint|nil
---@field OnDistant? fun(self: Wherigo.Zone)
---@field OnProximity? fun(self: Wherigo.Zone)
---@field OnEnter? fun(self: Wherigo.Zone)
---@field OnExit? fun(self: Wherigo.Zone)
---@field OnNotInRange? fun(self: Wherigo.Zone)
---@field OnSetActive? fun(self: Wherigo.Zone)
Wherigo.Zone = {}

---@param cartridge Wherigo.ZCartridge
---@return Wherigo.Zone
function Wherigo.Zone.new(cartridge) end

---@param object any
---@return boolean
function Wherigo.Zone:made(object) end

---@class Wherigo.ZItem: Wherigo.ZObject
---@field CurrentDistance? Wherigo.Distance
---@field CurrentBearing? Wherigo.Bearing
---@field OnClick? fun(self: Wherigo.ZItem)
Wherigo.ZItem = {}

---@param cartridge Wherigo.ZCartridge
---@param container? Wherigo.ZObject
---@return Wherigo.ZItem
function Wherigo.ZItem.new(cartridge, container) end

---@param object any
---@return boolean
function Wherigo.ZItem:made(object) end

---@class Wherigo.ZCharacter: Wherigo.ZObject
---@field Gender string
---@field InsideZones Wherigo.Zone[]
---@field CurrentDistance? Wherigo.Distance
---@field CurrentBearing? Wherigo.Bearing
---@field CompletionCode? string
---@field OnClick? fun(self: Wherigo.ZCharacter)
Wherigo.ZCharacter = {}

---@param cartridge Wherigo.ZCartridge
---@param container? Wherigo.ZObject
---@return Wherigo.ZCharacter
function Wherigo.ZCharacter.new(cartridge, container) end

---@param object any
---@return boolean
function Wherigo.ZCharacter:made(object) end

---@class Wherigo.ZTask: Wherigo.ZObject
---@field tasks integer Static task counter.
---@field SortOrder integer
---@field Complete boolean
---@field CorrectState boolean
---@field CompletedTime number
---@field OnClick? fun(self: Wherigo.ZTask)
---@field OnSetCorrectState? fun(self: Wherigo.ZTask)
---@field OnSetComplete? fun(self: Wherigo.ZTask)
---@field OnSetActive? fun(self: Wherigo.ZTask)
Wherigo.ZTask = {}
Wherigo.ZTask.tasks = 0

---@param cartridge Wherigo.ZCartridge
---@param container? Wherigo.ZObject
---@return Wherigo.ZTask
function Wherigo.ZTask.new(cartridge, container) end

---@param object any
---@return boolean
function Wherigo.ZTask:made(object) end

---@class Wherigo.ZTimer: Wherigo.ZObject
---@field Type "Countdown"|"Interval"|string
---@field Duration number
---@field Remaining number
---@field Running integer
---@field StartTime number
---@field OnStart? fun(self: Wherigo.ZTimer)
---@field OnStop? fun(self: Wherigo.ZTimer)
---@field OnTick? fun(self: Wherigo.ZTimer)
Wherigo.ZTimer = {}

---@param cartridge Wherigo.ZCartridge
---@return Wherigo.ZTimer
function Wherigo.ZTimer.new(cartridge) end

---@return nil
function Wherigo.ZTimer:Start() end

---@return nil
function Wherigo.ZTimer:Stop() end

---@return nil
function Wherigo.ZTimer:Tick() end

---@param id integer
---@return nil
function Wherigo.ZTimer._Tick(id) end

---@param object any
---@return boolean
function Wherigo.ZTimer:made(object) end

---@class Wherigo.ZInput: Wherigo.ZObject
---@field InputType? "Text"|"MultipleChoice"|string
---@field Choices string[]
---@field Text? string
---@field Media? Wherigo.ZMedia
---@field OnGetInput? fun(self: Wherigo.ZInput, response: string)
Wherigo.ZInput = {}

---@param cartridge Wherigo.ZCartridge
---@return Wherigo.ZInput
function Wherigo.ZInput.new(cartridge) end

---@param object any
---@return boolean
function Wherigo.ZInput:made(object) end

-- ============================================================================
-- Player
-- ============================================================================

---@class Wherigo.Player: Wherigo.ZCharacter
---@field CompletionCode? string
---@field Name string
---@field Id number
---@field InsideOfZones Wherigo.Zone[]
---@field CurrentDistance Wherigo.Distance|nil
---@field CurrentBearing Wherigo.Bearing|nil
---@field PositionAccuracy Wherigo.Distance
---@field LastLocationUpdate number
---@field ObjectLocation Wherigo.ZonePoint
---@field ObjIndex integer
---Global player object supplied by the runtime.
---The actual runtime replaces this with a Player instance; keeping it nil
---avoids constructing a ZCharacter with an invalid nil cartridge in LuaLS.
---@type Wherigo.Player|nil
Wherigo.Player = nil

---@return nil
function Wherigo.Player:RefreshLocation() end

---@param zone Wherigo.Zone
---@return nil
function Wherigo.Player._removeFromZone(zone) end

---Debug flag used by the runtime to expose hidden objects/zones.
---@type boolean
DEBUG = false

return Wherigo
