Parts of this code are explained in <http://www.nickhodges.com/post/Getting-Giddy-with-Dependency-Injection-and-Delphi-Spring-6-Dont-even-have-a-constructor.aspx>

Note that when using the Spring4D framework in these examples, these directories need to be added to your search path:

    $(Spring)\Source\Base;
    $(Spring)\Source\Base\Collections;
    $(Spring)\Source\Base\Reflection;
    $(Spring)\Source\Core\Container;
    $(Spring)\Source\Core\Services

Where `$(Spring)` is an environment variable pointing to the root of the Spring4D sources.

# 1-StartingOut\StartingOut.dproj

The classic way that most applications work: lots of dependencies.

0. unit `uDoOrderProcessing` has a method `DoOrderProcessing` that instantiates a `TOrder` which gets processed by a `TOrderProcessor`.
0. unit `uOrderProcessor` implements `TOrderProcessor` which has a hard-coded dependency on `TOrderValidator` from unit `uOrderValidator` and `TOrderEntry` from unit `uOrderEntry`.

The output is this, so processing an order always costs $1:

    Validating Order....
    Entering order into the database, at a cost of $1.... 
    Order has been processed....
    Order successfully processed....

# 2-MoveToInterfaces\MovingToInterfaces.dproj

0. in unit `uOrderEntry`, add an `IOrderEntry` interface containing the public methods of the `TOrderEntry` class, then make `TOrderEntry` derive from `TInterfacedObject` and have it implement `IOrderEntry`.
0. in unit `uOrderValidator`, add an `IOrderValidator` interface containing the public methods of the `TOrderValidator` class, then make `TOrderValidator` derive from `TInterfacedObject` and have it implement `IOrderValidator`.
0. in unit `uOrderProcessor`, add an `IOrderProcessor` interface containing the public methods of the `TOrderProcessor` class, then make `TOrderProcessor` derive from `TInterfacedObject` and have it implement `IOrderProcessor`.
0. in unit `uOrderProcessor`, make two more changes: replace the class types of `FOrderValidator` and `FOrderEntry` with the interface types. Then remove destructor `TOrderProcessor.Destroy`.
0. in unit `uDoOrderProcessing`, replace the type `TOrderProcessor` of `OrderProcessor` by `IOrderProcessor`, then remove the `OrderProcessor.Free`  and the `try/finally/end` block it is part of.

NB: You can use another ancestor than `TInterfacedObject` as long as it implements `IInterface`

At first sight, this might look like a pointless exercise, but it makes it much easier to separate implementations from interfaces to favour composition over inheritance.

# 3-ConstructorInjection\ConstructorInjection.dproj

0. in unit `uOrderProcessor`, in constructor `TOrderProcessor.Create` add the parameters `aOrderValidator: IOrderValidator` and `aOrderEntry: IOrderEntry`. Then assign those to the fields `FOrderValidator` and `FOrderEntry`, and remove the creation of `TOrderValidator` and `TOrderEntry` instances.
0. in unit `uDoOrderProcessing`, add the units `uOrderValidator` and `uOrderEntry` to the implementation uses list.
0. in unit `uDoOrderProcessing`, in method `DoOrderProcessing` add local variables `OrderValidator: IOrderValidator` and `OrderEntry: IOrderEntry`.
0. in unit `uDoOrderProcessing`, in method `DoOrderProcessing` initialize those variables using `OrderValidator := TOrderValidator.Create` and `OrderEntry := TOrderEntry.Create`, then pass them in `TOrderProcessor.Create(OrderValidator, OrderEntry)`. 

Note you can do without the intermediate variables, but step 4 (Mocks) will make an important aspect of that clear.

The above changes will have the `TOrderProcessor` class gets the dependencies injected at run-time.

# 4-UseMocks\UseMocks.dproj

This is a small and important side-step from step 3: Mocks are very useful for unit testing, but usually not found in your production applications. 

Add unit `uOrderEntryMock` with a class `TOrderEntryMock` that is like `TOrderEntry`, but has a method `TOrderEntryMock.EnterOrderIntoDatabase` that has an implementation like this:
  
    Result := True;  
    {$IFDEF CONSOLEAPP}  
    Writeln('TOrderEntryMock.EnterOrderIntoDatabase called');  
    {$ENDIF}  

Add unit `uOrderValidatorMock` with a class `TOrderValidatorMock` that is like `TOrderValidator`, but has a method `TOrderValidatorMock.ValidateOrder` that has an implementation like this:

    Result := True;
    {$IFDEF CONSOLEAPP}
    Writeln('TOrderValidatorMock.ValidateOrder called');
    {$ENDIF}

Change unit `uDoOrderProcessing`:

0. in the implementation uses list, add the units `uOrderValidatorMock` and `uOrderEntryMock`
0. replace the creation parameters with `TOrderValidatorMock.Create, TOrderEntryMock.Create`

This shows one of the big advantages of dependency injection: you can switch the dependencies.

And you don't get the $1 hit any more:

    TOrderValidatorMock.ValidateOrder called
    TOrderEntryMock.EnterOrderIntoDatabase called
    Order has been processed....
    Order successfully processed....

But it also shows an important flaw that we will solve in step 5: still the units `uOrderValidator` and `uOrderEntry` are needed because they contain the interface definitions `IOrderValidator` and `IOrderEntry`.

# 5-IsolateInterfaces\IsolateInterfaces.dproj

The changes here are against step 3:

0. Add a new unit `uOrderInterfaces` and move the interfaces `IOrderValidator` (from unit `uOrderValidator`), `IOrderEntry` (from unit `uOrderEntry`) and `IOrderProcessor` (from unit `uOrderProcessor`).
0. in unit `uOrderEntry`, add `uOrderInterfaces` to the uses list, and remove the `IOrderEntry` interface.
0. in unit `uOrderProcessor`, add `uOrderInterfaces` to and remove units `uOrderEntry` and `uOrderValidator` from the uses list and remove the `IOrderProcessor` interface.
0. in unit `uOrderValidator`, add `uOrderInterfaces` to the uses list and remove the `IOrderValidator` interface.
0. in unit `uDoOrderProcessing`, use the unit `uOrderInterfaces`, then change the type of `OrderProcessor` back from `TOrderProcessor` to `IOrderProcessor` and remove the `try/finally/free/end` block.

This isolates the interfaces from the units implementing them, further isolating them and further reducing dependencies between the implementation units.

With the above changes, the changes for step 4 would be simpler and eliminate the needs for units `uOrderValidator` and `uOrderEntry`.

# 6-UseContainer\UseContainer.dproj

0. in unit `uOrderInterfaces`, add GUIDs to the various interfaces (`IOrderValidator`, `IOrderEntry` and `IOrderProcessor`).
0. in unit `uOrderEntry`, add `Spring.Container`, then add `GlobalContainer.RegisterType<TOrderEntry>` to the `initialization` section.
0. in unit `uOrderValidator`, add `Spring.Container`, then add `GlobalContainer.RegisterType<TOrderValidator>` to the `initialization` section.

The first step is needed to that the dependency injection framework can tell the interfaces apart.
The other steps perform one of the cruxes for dependency injection: making sure the implementing classes are registered.

Though dependency injection tries to minimize the use of global (and singleton) objects, this is the exception: it is a trade of between having many singletons in various different places versus one singleton object.

Then the big set of changes in the unit `uDoOrderProcessing`:

0. Add the units `Spring.Container` and `Spring.Services` to the uses list.
0. Remove the units `uOrderValidator` and `uOrderEntry` from the uses list.
0. As the first statement in the body of procedure `DoOrderProcessing`, call `GlobalContainer.Build`;
0. Use the `ServiceLocator.GetService<T>`  for `IOrderValidator` and `IOrderEntry`, and put them in `OrderValidator` and `OrderEntry`.

The call to `GlobalContainer.Build` must take place right before the main logic of your program. It builds the dependency graph so it knows which dependencies are there and how to resolve them.

The calls to `ServiceLocator.GetService<T>` resolve the dependencies (have the framework create instances) for the interfaces from the dependency graph: it finds the underlying classes, then creates instances from them with the right constructor and parameters.

##### Note: this line should move within the try block:

`  OrderProcessor := TOrderProcessor.Create(TOrderValidator.Create, TOrderEntry.Create);`

# 7-CustomConstructor\CustomConstructor.dproj

0. in unit `uOrderProcessor`, add the unit `Spring.Container` to the implementation uses list
0. in unit `uOrderProcessor`, add the statement `GlobalContainer.RegisterType<TOrderProcessor>` to the initialization section.
0. in unit `uDoOrderProcessing`, remove the unit `uOrderProcessor` from the uses list.
0. in unit `uDoOrderProcessing`, move the uses list from the interface to the implementation.
0. in unit `uDoOrderProcessing`, move the `TOrderProcessor` class declaration from the interface to the implementation.
0. in unit `uDoOrderProcessing`, remove the variables `OrderValidator` and `OrderEntry`, their initialization and their use in the `TOrderProcessor.Create` call.
0. in unit `uDoOrderProcessing`, initialize `OrderProcessor` using `ServiceLocator.GetService<IOrderProcessor>` 

(in unit `uOrderProcessor`, there is also a change to a `const` parameter, but that is not strictly needed).

What happens here is that the dependency injection framework now understand the implementation of `IOrderProcessor` is the class `TOrderProcessor` that has a constructor with two other dependencies of type `IOrderValidator` and `IOrderEntry`. Before calling the constructor, it resolves those as well.

You might want to skip the last two steps (moving the uses list and class from interface to implementation) as that makes it a lot harder to unit test the `TOrderProcessor` using DUnit or DUnitX: you would need a dependency injection tool for DUnit/DUnitX which contradicts the aim of making unit tests as simple as possible.

# 8-FieldInjection\FieldInjection.dproj

All changes are in unit `uOrderProcessor`:

0. add the unit `Spring.Services` to the interface uses list.
0. add the attribute `[Inject]` from unit `Spring.Services` to the fields `FOrderValidator` and `FOrderEntry`.
0. remove the constructor `TOrderProcessor.Create`.
0. remove the unit `Spring.Container` from the uses list in the implementation section.

The attributes instruct the dependency framework to also take the fields into account when resolving dependencies. It is smart enough to fill those fields with their dependencies after calling the constructor.
