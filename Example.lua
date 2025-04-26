
addParagraph("Chào mừng đến với Script Hub!")
addToggle("Auto Chest", function(state) _G.AutoCollectChest = state end)
addToggle("Auto Rau Đen", function(state) _G.AutoRauDen = state end)
addTextBox("Nhập tên nhân vật", function(text) print("Tên:", text) end)
addDropdown({"Option 1", "Option 2", "Option 3"}, function(opt) print("Chọn:", opt) end)
