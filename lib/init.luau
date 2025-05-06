local Promise = require(script.Parent.Promise)

local ActorUtils = {}

--[=[
	Calls an actors `:SendMessage` with the given topic and args and returns a promise which resolves
	with the return of the actor
]=]
function ActorUtils.WrapActorMessageWithPromise(actor: Actor, topic: string, ...: any)
	local actorArgs = { ... }

	return Promise.new(function(resolve)
		local newEvent = Instance.new("BindableEvent")
		actor:SendMessage(topic, newEvent, table.unpack(actorArgs))
		newEvent.Event:Once(function(...)
			newEvent:Destroy()
			resolve(...)
		end)
	end)
end

return ActorUtils
