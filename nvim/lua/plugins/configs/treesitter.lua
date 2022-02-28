local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "maintained",
  sync_install = false,
  highlight= {
        enable = true,
        disable= { "" },
        additional_vim_regex_highlighting = true
  },
  indent = { enable = false, disable = {'yaml'} },
  context_commentstring = {
        enable = true,
        enable_autocmd = false
 },
 autotag = {
   enable = true
 }

}
