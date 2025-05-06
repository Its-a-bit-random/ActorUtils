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