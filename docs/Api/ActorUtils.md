# Actor Utils

## `WrapActorMessageWithPromise()`

```luau
WrapActorMessageWithPromise(actor: Actor, topic: string, ...:any): Promise
```

Calls the passed `Actor`'s `:SendMessage()` function with the given topic and forwards all args passed. Do note that it automatically also passes a bindable event as the first argument for the actor's `:SendMessage()`. Here is a basic example to show how to use this function:

In your calling script
```luau
WrapActorMessageWithPromise(myActor, "SayHello", "John"):andThen(function(helloMessage)
	print(helloMessage) -- "Hello John"
end)
```

Then in your actor script
```luau
script:GetActor():BindToMessage("SayHello", function(Return: BindableEvent, personName: string)
	Return:Fire(`Hello {personName}`)
end)
```

## `BindToMessage()`
```luau
ActorUtils.BindToMessage(actor: Actor, topic: string, handler: (...any) -> ...any): nil
```
calls `Actor:BindToMessage()` but automatically handles return events that are passed by [`WrapActorMessageWithPromise()`](#wrapactormessagewithpromise).
Taking the example above it would be reduced to:

In your calling script
```luau
WrapActorMessageWithPromise(myActor, "SayHello", "John"):andThen(function(helloMessage)
	print(helloMessage) -- "Hello John"
end)
```

Then in your actor script
```luau
BindToMessage(script:GetActor(), "SayHello", function(personName: string)
	return `Hello {personName}`
end)
```

## `BindToMessageParallel()`
```luau
ActorUtils.BindToMessageParallel(actor: Actor, topic: string, handler: (...any) -> ...any): nil
```

Does the same thing as [`BindToMessage()`](#bindtomessage) except using `Actor:BindToMessageParallel()` instead of `Actor:BindToMessage()`