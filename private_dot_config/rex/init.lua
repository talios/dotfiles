

rex.action{
  name  = "scratch",
  title = "Open Scratch Window",
  run   = function(ctx, args)
    rex.session.new_window{
      layout = rex.layout.block{
        flavor = "com.superlogical.terminal.shell",
      },
    }
  end,
}

