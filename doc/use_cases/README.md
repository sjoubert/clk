Here are some use cases that hopefully will have the following properties:

-   provide a better idea of what clk is capable of than a simple description,
-   show some common pattern that emerged when using clk,
-   give examples of real life uses of clk, giving hints about when it might be useful,

If you simply want to create bash commands, take a look at [this one](bash_command.md). This [other one](bash_command_use_option.md) provides more insights about how to define options. When those will get bigger, take a look at how to [split your code](bash_command_import.md). In particular, you might want to start small with [simple alias and then move to bash commands](bash_command_from_alias.md). Also, clk provides some useful "[batteries](bash_command_built_in_lib.md)" to help you create a nice and friendly command.

Sometimes, you might want to have some control about how the arguments of the command lines are evaluated, take a look at [this use case](controlling_a_server_using_an_environment_variable.md) to know more about them.

Also, to create powerful, dynamic command line tools that provide the best completion possible, see [this pattern](dynamic_parameters_and_exposed_class.md) for writing your commands. In case you have some issues, you might want to look at the [advanced use cases](dynamic_parameters_advanced_use_cases.md).

When you want to provide some choices in command, it might be worthwhile to look at [those examples](choices.md).

To cache some computation to disk, see the [web scrapping](scrapping_the_web.md) use case.

If at some point you need to deal with a project, you might want to [read this](using_a_project.md).

But, eventually, you might want to use python commands to have a full control over the user experience. Then, you might want a quick look at the [available helpers](lib.md).

At some point, you will definitely want to try the use case about [a 3D printing flow](3D_printing_flow.md).

If you don't want to use the clk command line tool, you can [roll your own](rolling_your_own.md).

Some commands might need to use secret, [here is how](dealing_with_secrets.md) we implement that.

This example of an [ethereum local environment dev tool](ethereum_local_environment_dev_tool.md) shows how to plug clk commands as parameters in other commands. [ipfs name publish](ipfs_name_publish.md) shows how to use clk bash commands to create the completion for other commands.
