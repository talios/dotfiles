

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

-- >>> leaf >>>
-- Managed by `leaf rex install`; `leaf rex uninstall` removes it.
-- plugin: 3f4010a57a8d8e3d
dofile("/Users/amrk/.config/rex/plugins/leaf/init.lua").setup({ bin = { "/opt/homebrew/bin/leaf" } })
-- open: idle classic
-- <<< leaf <<<
