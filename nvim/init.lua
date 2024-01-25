local ok, err = pcall(require, 'main')

if not ok then
  print('Error: ' .. err)
end
