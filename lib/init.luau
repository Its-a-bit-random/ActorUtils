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

--[=[
	Wrapper for `Actor:BindToMessage()` that automatically handles the return event. Should only be used if you are calling
	with `WrapActorMessageWithPromise`.
]=]
function ActorUtils.BindToMessage(actor: Actor, topic: string, handler: (...any) -> ...any)
	actor:BindToMessage(topic, function(returnEvent: BindableEvent, ...)
		returnEvent:Fire(handler(...))
	end)
end

--[=[
	Same as `BindToMessage` except connects with `:BindToMessageParallel()`
]=]
function ActorUtils.BindToMessageParallel(actor: Actor, topic: string, handler: (...any) -> ...any)
	actor:BindToMessageParallel(topic, function(returnEvent: BindableEvent, ...)
		returnEvent:Fire(handler(...))
	end)
end

return ActorUtils
