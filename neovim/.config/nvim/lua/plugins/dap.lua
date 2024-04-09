require ('mason-nvim-dap').setup({
    ensure_installed = {'stylua', 'jq', 'netcoredbg'},
    handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
            config.adapters = {
	            type = "executable",
	            command = "/usr/bin/python3",
	            args = {
		            "-m",
		            "debugpy.adapter",
	            },
            }
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
    },
})

vim.keymap.set(
'n',
   '<leader>dR',
   function()
     require('dap').run_to_cursor()
   end,
   { desc = 'Run to Cursor'})
 vim.keymap.set(
 'n',
   '<leader>dE',
   function()
     require('dapui').eval(vim.fn.input '[Expression] > ')
   end,
   { desc = 'Evaluate Input'})
 vim.keymap.set(
 'n',
   '<leader>dC',
   function()
     require('dap').set_breakpoint(vim.fn.input '[Condition] > ')
   end,
   { desc = 'Conditional Breakpoint'})
 vim.keymap.set(
 'n',
   '<leader>dU',
   function()
     require('dapui').toggle()
   end,
   { desc = 'Toggle UI'})
 vim.keymap.set(
 'n',
   '<leader>db',
   function()
     require('dap').step_back()
   end,
   { desc = 'Step Back'})
 vim.keymap.set(
 'n',
   '<leader>dc',
   function()
     require('dap').continue()
   end,
   { desc = 'Continue'})
 vim.keymap.set(
 'n',
   '<leader>dd',
   function()
     require('dap').disconnect()
   end,
   { desc = 'Disconnect'})
 vim.keymap.set(
 'n',
   '<leader>de',
   function()
     require('dapui').eval()
   end,
   { desc = 'Evaluate'})
 vim.keymap.set(
 'n',
   '<leader>dg',
   function()
     require('dap').session()
   end,
   { desc = 'Get Session'})
 vim.keymap.set(
 'n',
   '<leader>dh',
   function()
     require('dap.ui.widgets').hover()
   end,
   { desc = 'Hover Variables'})
 vim.keymap.set(
 'n',
   '<leader>dS',
   function()
     require('dap.ui.widgets').scopes()
   end,
   { desc = 'Scopes'})
 vim.keymap.set(
 'n',
   '<leader>di',
   function()
     require('dap').step_into()
   end,
   { desc = 'Step Into'})
 vim.keymap.set(
 'n',
   '<leader>do',
   function()
     require('dap').step_over()
   end,
   { desc = 'Step Over'})
 vim.keymap.set(
 'n',
   '<leader>dp',
   function()
     require('dap').pause.toggle()
   end,
   { desc = 'Pause'})
 vim.keymap.set(
 'n',
   '<leader>dq',
   function()
     require('dap').close()
   end,
   { desc = 'Quit'})
 vim.keymap.set(
 'n',
   '<leader>dr',
   function()
     require('dap').repl.toggle()
   end,
   { desc = 'Toggle REPL'})
 vim.keymap.set(
 'n',
   '<leader>ds',
   function()
     require('dap').continue()
   end,
   { desc = 'Start'})
 vim.keymap.set(
 'n',
   '<leader>dt',
   function()
     require('dap').toggle_breakpoint()
   end,
   { desc = 'Toggle Breakpoint'})
 vim.keymap.set(
 'n',
   '<leader>dx',
   function()
     require('dap').terminate()
   end,
   { desc = 'Terminate'})
 vim.keymap.set(
 'n',
   '<leader>du',
   function()
     require('dap').step_out()
   end,
   { desc = 'Step Out'})
