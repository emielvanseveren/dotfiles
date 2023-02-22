local present, web_devicons = pcall(require, "nvim-web-devicons")

if not present then
  return
end

web_devicons.setup()
